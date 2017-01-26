import sys
import os

def diskretiziraj_granicnima(vrijednosti,granicne):
    izlaz=[]
    for vrijednost in vrijednosti:
        izlaz.append(pronadji(vrijednost,granicne))                
    return izlaz

def pronadji(vrijednost,granicne):
    for i,granicna in enumerate(granicne):
        if vrijednost<=granicna:
            return i+1
    return i+2

def divide_zero(a,b):
    if b==0:
        return 0.
    return a/float(b)

directory=sys.argv[1]
output1=[]
file1=open(sys.argv[1]+'.out1','w')
file1.write('tekst\tkorpus\ttokeni\tttr\trecenice\tduzina.recenica\tleks.gust\tceste.reci\tceste.leme\tduzina.recenica.2\tleks.gust.2\tceste.reci.2\tceste.leme.2\n')
output2=[]
file2=open(sys.argv[1]+'.out2','w')
file2.write('tekst\tkorpus\treci\tduzina.reci\tinfinitivi\ttrebati\tda\timen.glag\tduzina.reci.2\n')
reference_tok=set([e.decode('utf8').strip() for e in open(sys.argv[2]+'.200.tok')])
reference_lem=set([e.decode('utf8').strip() for e in open(sys.argv[2]+'.200.lem')])

for file in os.listdir(directory):
    if file.endswith('.taglem'):
        no_sents=0
        no_tokens=0
        types=set()
        no_words=0
        word_len=0
        no_lexical=0
        freq_words=0
        freq_lemmas=0
        no_infs=0
        no_verbs=0
        no_nouns=0
        no_trebati3s=0
        no_trebati=0
        no_da=0
        no_imglag=0
        for line in open(os.path.join(directory,file)):
            if line=='\n':
                no_sents+=1
            else:
                token,lemma,tag=line.decode('utf8').strip().split('\t')
                types.add(token)
                no_tokens+=1
                if tag.startswith('V'):
                    no_verbs+=1
                    if tag in ('Vmn','Van'):
                        no_infs+=1
                if tag.startswith('N'):
                    no_nouns+=1
                if lemma=='trebati':
                    no_trebati+=1
                    if tag.endswith('3s'):
                        no_trebati3s+=1
                if lemma=='da' and tag=='Cs':
                    no_da+=1
                if tag!='Z' and not tag.startswith('X'):
                    if token.lower() in reference_tok:
                        freq_words+=1
                    if lemma in reference_lem:
                        freq_lemmas+=1
                    no_words+=1
                    word_len+=len(token)
                    if tag[0] not in 'PSCQI' and tag[:2]!='Va' and tag!='Rgp':
                        no_lexical+=1
        output1.append((directory+'.'+file,directory,no_tokens,divide_zero(len(types),no_tokens),no_sents,divide_zero(no_tokens,no_sents),divide_zero(no_lexical,no_words),divide_zero(freq_words,no_words),divide_zero(freq_lemmas,no_words)))
        output2.append((directory+'.'+file,directory,no_words,divide_zero(word_len,no_words),divide_zero(no_infs,no_verbs),divide_zero(no_trebati3s,no_trebati),divide_zero(no_da,no_words*10000),divide_zero(no_nouns,no_nouns+no_verbs)))
add1=zip(diskretiziraj_granicnima([e[5] for e in output1],[20,30,40,50]),diskretiziraj_granicnima([e[6] for e in output1],[0.5,0.6,0.7]),diskretiziraj_granicnima([e[7] for e in output1],[0.3,0.4,0.5]),diskretiziraj_granicnima([e[8] for e in output1],[0.44,0.59]))
add2=diskretiziraj_granicnima([e[3] for e in output2],[20,30,40,50])
for o,a in zip(output1,add1):
    file1.write('\t'.join([str(e) for e in o])+'\t'+'\t'.join([str(e) for e in a])+'\n')
for o,a in zip(output2,add2):
    file2.write('\t'.join([str(e) for e in o])+'\t'+str(a)+'\n')
file1.close()
file2.close()
