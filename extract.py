import sys
import os

directory=sys.argv[1]
output=open(sys.argv[1]+'.out','w')
output.write('tekst\tkorpus\ttokeni\ttipovi\trecenice\tduzina.recenice\tleks.gust\tceste.reci\tceste.leme\n')
reference_tok=set([e.decode('utf8').strip() for e in open(sys.argv[2]+'.200.tok')])
reference_lem=set([e.decode('utf8').strip() for e in open(sys.argv[2]+'.200.lem')])

for file in os.listdir(directory):
    if file.endswith('.taglem'):
        no_sents=0
        no_tokens=0
        types=set()
        no_words=0
        no_lexical=0
        freq_words=0
        freq_lemmas=0
        for line in open(os.path.join(directory,file)):
            if line=='\n':
                no_sents+=1
            else:
                token,lemma,tag=line.decode('utf8').strip().split('\t')
                types.add(token)
                no_tokens+=1
                if tag!='Z' and not tag.startswith('X'):
                    if token.lower() in reference_tok:
                        freq_words+=1
                    if lemma in reference_lem:
                        freq_lemmas+=1
                    no_words+=1
                    if tag[0] not in 'PSCQI' and tag[:2]!='Va' and tag!='Rgp':
                        no_lexical+=1
        output.write(directory+'.'+file+'\t'+directory.strip('/')+'\t'+str(no_tokens)+'\t'+str(len(types))+'\t'+str(no_sents)+'\t'+str(float(no_tokens)/no_sents)+'\t'+str(float(no_lexical)/no_words)+'\t'+str(float(freq_words)/no_words)+'\t'+str(float(freq_lemmas)/no_words)+'\n')
output.close()
