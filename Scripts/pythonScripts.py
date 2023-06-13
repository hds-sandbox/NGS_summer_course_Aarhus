### SDO outlyingness for scater PCA-based filtering (adjOutlyingness of the R robust package used in scater for scrna filtering)
###  (adjOutlyingness.R of the R `robust` package used in `scater` for scrna filtering in R)

import numpy as np
from robustbase import mad
from sklearn.decomposition import PCA
from sklearn.preprocessing import scale
import scanpy as sc
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
from IPython.display import HTML, display
from IPython.core.magic import register_cell_magic

def set_background(color):    
    script = (
        "var cell = this.closest('.jp-CodeCell');"
        "var editor = cell.querySelector('.jp-Editor');"
        "editor.style.background='{}';"
        "this.parentNode.removeChild(this)"
    ).format(color)

    display(HTML('<img src onerror="{}">'.format(script)))
    
@register_cell_magic
def background(color, cell):
    set_background(color)

def directions(Xpca): #directions for points projection
    n, p = Xpca.shape
    P = Xpca[ np.random.choice(n, replace=False, size=p), :]
    G = np.zeros(p)
    E = np.ones(p)
    qrP, _ = np.linalg.qr(P)
    G2 = np.linalg.solve(qrP, E)
    return G2

def outlyingness(Xpca, N):
    Nx, p = Xpca.shape
    a = np.zeros([N,p])
    for i in range(N):
        a[i,:] = directions(Xpca)  
    all_values = np.zeros([Nx,N])
    for i in range(N):
        w = np.matmul(Xpca, a[i,:])
        all_values[:,i] = abs(w-np.median(w))/mad(w)
    return all_values

def PCAfiltering(adata, obs_subset=None, p=2, N=100, plot=True, random_seed=42):

    np.random.seed(random_seed)
    print(f'--- PCA of dimension {p} on the following metadata:')
    if obs_subset==None:
        X = adata.obs
        print(list(adata.obs.columns))
    else:
        X = adata.obs[list(obs_subset)]
        print(obs_subset)
    print(f'on a sample with {X.shape[0]} datapoints')
    X2 = scale(X)
    Xpca = PCA(n_components=p).fit_transform(X2)
    
    print(f'--- Calculate outlyingness on {N} randomly sampled axae, (random seed {random_seed})')
    outlying_values = outlyingness(Xpca, N)
    sup_outlyingness = np.max(outlying_values, 1)
    mad_SDO = mad(sup_outlyingness)
    median_SDO = np.median(sup_outlyingness)
    outliers = sup_outlyingness > median_SDO + 5*mad_SDO
    adata.obs['SDO_outliers'] = pd.Categorical(outliers)
    adata.obs['SDO_outlyingness'] = sup_outlyingness
    
    print(f'--- Found {np.sum(outliers)} outliers')
    print('--- Returned annotated data object containing')
    print('--- * adata.obs["SDO_outliers"]: boolean variable identifying outliers')
    print('--- * adata.obs["SDO_outlyingness"]: outlyingness of each cell')
    
    if(plot):
        import matplotlib.pyplot as plt
        fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(20,4), gridspec_kw={'wspace':0.9})
        x1 = sns.scatterplot(x=Xpca[:,0], y=Xpca[:,1], hue=sup_outlyingness, ax=ax1)
        x1.set_title('Outlyingness on\nmetadata PCA')
        x2 = sns.scatterplot(x=Xpca[:,0], y=Xpca[:,1], hue=outliers, ax=ax2)
        x2.set_title('Outliers on\nmetadata PCA')
        x3 = sns.scatterplot(x='total_counts', y='n_genes_by_counts', data=adata.obs, hue=outliers, ax=ax3)
        x=x3.set_title('Outliers on scatterplot\n#Transcripts vs #Genes')

    return adata

###PCA detection of highly dependent technical features
def dependentFeatures(adata, obs_subset=['total_counts'], n_pcs = 10):
    
    from sklearn.linear_model import LinearRegression as LR
    from sklearn.metrics import mean_squared_error, r2_score
    from matplotlib.lines import Line2D  
    
    L = len(obs_subset)
    X = pd.DataFrame(adata.obsm['X_pca'][:,:n_pcs], columns=[f'PC{i}' for i in range(n_pcs)])
    Y = adata.obs[obs_subset]
    scores = np.zeros([n_pcs, L])
    
    for n in range(n_pcs):
        for l in range(L):
            #reg = LR().fit(X[f'PC{n}'].reshape(-1,1), Y[obs_subset[l]].reshape(-1,1))
            reg = LR().fit(np.array(X[f'PC{n}']).reshape(-1,1), np.array(Y[obs_subset[l]]).reshape(-1,1))
            pred = reg.predict(np.array(X[f'PC{n}']).reshape(-1,1))          
            scores[n, l] = r2_score(Y[obs_subset[l]], pred)
            
    max_scores = np.max(scores, 0)
    argmax_scores = np.argmax(scores, 0)
 
    fig, ax = plt.subplots(L, 1, figsize=(6,6*L), gridspec_kw={'hspace':0.4})
    for l in range(L):
        x1 = sns.regplot(x=X[f'PC{argmax_scores[l]}'], y=Y[obs_subset[l]], ax=ax[l], scatter_kws={'alpha':0.3})
        x = x1.set_title(f'Best lin.regression:\n {obs_subset[l]} VS PC {argmax_scores[l]}\nR score {max_scores[l]}')
        x1.set(ylabel=f'{obs_subset[l]}', xlabel=f'PC {argmax_scores[l]}')
        
###calculate markers' scores from a dictionary
def marker_score(markers_dict, adata, N_samples=100, random_seed=42):
    np.random.seed(random_seed)
    markers_list = []
    N_genes = adata.shape[1]
    random_genes = np.unique( np.random.randint(low=0, high=N_genes, size=N_samples) )
    gene_names = adata.var_names[random_genes]
    for i in markers_dict:
        markers_list.append(f'{i}_score')
        adata.obs[f'{i}_score'] = np.array(np.mean(adata[:,markers_dict[i]].X,1) - np.mean(adata[:,gene_names].X,(0,1)))
    return markers_list, adata

###function to rename clusters from a dictionary
def rename_clusters(names_dict, names_obs):
    clusters = pd.Categorical(names_obs)
    clusters=clusters.rename_categories(names_dict)
    cluster_array = np.array(clusters)
    split_array = [ i.split('.')[0] for i in cluster_array ]
    clusters = pd.Categorical(split_array)
    return clusters

###function to plot variant density in VCF file analysis
def plot_variant_density(variants, window_size, title=None):
    
    # setup windows 
    bins = np.arange(0, variants['variants/POS'][:].max(), window_size)
    x = (bins[1:] + bins[:-1])/2
    
    # compute variant density in each window
    h, _ = np.histogram(variants['variants/POS'][:], bins=bins)
    y = h / window_size
    
    # plot
    fig, ax = plt.subplots(figsize=(11, 3))
    sns.despine(ax=ax, offset=10)
    ax.plot(x, y)
    ax.set_xlabel('Contig position (bp)')
    ax.set_ylabel('SNP density (bp$^{-1}$)')
    if title:
        ax.set_title(title)

###function to plot parameters from the VCF files
def plot_variant_hist(variants, f, colour="mediumblue", bins=50):
    x = variants['variants/'+f][:]
    fig, ax = plt.subplots(figsize=(9, 4))
    sns.despine(ax=ax, offset=10)
    ax.hist(x, bins=bins, color = colour)
    ax.set_xlabel(f)
    ax.set_ylabel('No. SNPs')
    ax.set_title('Variant %s distribution' % f)

###function to count het and hom positions in VCF file analysis
def position_count(vcf_file):
    pos_missing = allel.GenotypeChunkedArray(vcf_file['calldata/GT']).count_missing(axis=0)[:]
    pos_het = allel.GenotypeChunkedArray(vcf_file['calldata/GT']).count_het(axis=0)[:]
    pos_hom_ref = allel.GenotypeChunkedArray(vcf_file['calldata/GT']).count_hom_ref(axis=0)[:]
    pos_hom_alt = allel.GenotypeChunkedArray(vcf_file['calldata/GT']).count_hom_alt(axis=0)[:]
    print("Count missing positions:", int(pos_missing))
    print("Count heterozygous positions:", pos_het)
    print("Count homozygous reference positions:", pos_hom_ref)
    print("Count homozygous alternate positions:", pos_hom_alt)
    
###function to create pseudobulk matrix    
def pseudobulk_matrix(adata, batch_key, condition_key, cluster_key, Nsamples=10, Ncells=10, random_seed=42):
    
    np.random.seed(random_seed)
    
    clusters = list()
    conditions = list()
    matrix_bulk = pd.DataFrame( index = adata.var_names )
    
    for BATCH in adata.obs[batch_key].cat.categories:
        #M1 = adata[ adata.obs[batch_key]==BATCH, : ].copy()
        print(f'{BATCH}')
        for COND in adata.obs[condition_key].cat.categories:
            print(f'----{COND}')
            #M2 = M1[ M1.obs[condition_key]==COND, : ].copy()
            for CLUST in adata.obs[cluster_key].cat.categories:
                print(f'--------{CLUST}')
                #M3 = M2[ M2.obs[cluster_key]==COND, : ].copy()
                M = adata[(adata.obs[batch_key]==BATCH)&(adata.obs[condition_key]==COND)&(adata.obs[cluster_key]==CLUST)].layers['raw_counts'].copy()
                M = M.todense()
                if(M.shape[0]>1):
                    for i in range(Nsamples):
                        integ = np.random.randint(low=0, high=M.shape[0]-1, size=min(Ncells, M.shape[1]))
                        #Ph[i,:] = np.mean( Xh[ integ, : ], axis=0 )
                        #integ = np.random.random_integers(low=0, high=M.shape[0]-1, size=20)
                        matrix_bulk[f'{COND}_{BATCH}_{CLUST}_{i}'] = np.ravel( np.sum( M[integ,:], axis=0 ) )
                        clusters.append(CLUST)
                        conditions.append(COND)
                else:
                    print(f'Only {M.shape[0]} cells: skipping')
    return matrix_bulk, clusters, conditions
    
def pseudobulk_extract_DEG(pbulk, adata, DE_key='rank_genes_groups'):
    print('---Extracting results')
    result = pbulk.uns['rank_genes_groups']
    groups = result['names'].dtype.names
    X = pd.DataFrame(
        {group + '_' + key.upper(): result[key][group]
        for group in groups for key in ['names', 'pvals','pvals_adj','logfoldchanges']})
    
    #expression matrix from the original data, normalized depths and logarithmized
    adata.X = adata.layers["raw_counts"].todense().copy()
    sc.pp.normalize_per_cell(adata)
    sc.pp.log1p(adata)

    mat = adata[:, X['Crypto_NAMES'] ].X.copy()

    #percentage
    X['Healthy_PCT'] = np.sum( mat[adata.obs['condition']=='Healthy', :]>0, 0) / adata[adata.obs['condition']=='Healthy', :].shape[0] * 100
    X['Crypto_PCT'] = np.sum( mat[adata.obs['condition']=='Crypto', :]>0, 0) / adata[adata.obs['condition']=='Crypto', :].shape[0] * 100

    #foldchange and log-pvalues
    X['Crypto_FOLDCHANGES'] = 2**X['Crypto_LOGFOLDCHANGES']
    X['Crypto_LOGPVALS_ADJ'] = -np.log10(X['Crypto_PVALS_ADJ']+1e-50)
    X['Crypto_LOGPVALS'] = -np.log10(X['Crypto_PVALS']+1e-50)
    
    print('---done')
    
    return X

def pseudobulk_volcano(X, logpval_threshold=3, logfold_threshold=2, plot_size=(800,800)):
    import plotly.express as px
    
    hue = ['SIGN.' if (P>logpval_threshold)&(L>logfold_threshold) else 'NOT.SIGN.' 
           for P,L in zip(X['Crypto_LOGPVALS_ADJ'],np.abs(X['Crypto_LOGFOLDCHANGES'])) ]

    fig = px.scatter(x='Crypto_LOGFOLDCHANGES', 
                 height=plot_size[1],
                 width=plot_size[0],
                 color=hue,
                 y='Crypto_LOGPVALS_ADJ', 
                 hover_name='Crypto_NAMES', 
                 size='Crypto_PCT',
                 data_frame=X)
    fig.show()