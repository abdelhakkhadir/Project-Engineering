clc
clear all
function [argument]=calc_argu(a)
    cosa=real(a)/abs(a)
    sina=imag(a)/abs(a)
    tana=sina/cosa    
    argument=atan(tana);
    degre= argument *180/%pi;
    disp("voila votre argument en radian"+ string(argument));
    disp("voila votre argument en degrees " + string(degre))
endfunction
function [res] =polynome(a)
    poli=poly(a,"x")
    disp(poli)
    verfie= horner(poli,a)
    derv=derivat(poli)
    disp(derv)
endfunction
function [deriver] = derive(poli, coef)
    deg = degree(poli); // Cherche le degré du polynôme
    l = length(coef); // Cherche combien de coefficients on a 
    remp = zeros(1, l - 1); // Nouveau vecteur de coefficients sans la constante
    disp(deg); // Affiche le degré du polynôme
    n = 1; // Initialisation de n pour le calcul des dérivées

    // Boucle pour dériver chaque coefficient
    for t = 1:deg // On boucle de 1 jusqu'au degré
        remp(t) = coef(t + 1) * n; // Calcule la dérivée directe
        n = n + 1; // On incrémente n pour abaisser le degré
    end

    k = [remp]; // Crée un tableau pour les coefficients dérivés
    // La constante devient 0, donc pas besoin de l'affecter
    deriver = poly(k, 'x', 'coeff'); // Crée le polynôme dérivé
    disp(deriver); // Affiche le résultat
endfunction
function t=gener_temp(F0,Nt,Np)
    T0=1/F0
    TE=T0/Nt
    TFS=Np*T0
    t=0:TE:TFS
    
endfunction
function [x,t]=my_sin(A,F0,NT,NP,x0)//cree une fonction sin comme la formule l equige 
    t=gener_temp(F0,NT,NP)
    x=A*sin(2*%pi*F0*t)+x0
endfunction
function x0=calc_moy(x)
    x0=(sum(x(1:length(x))))/length(x)//pour les droite retire le -1 vu que por les sin cos la pointe ne compte^pas qaund tu fais les dent s de requins 
endfunction
function [x,t]=my_ramp_neg1(E,T,NT)//cree la rampe demander dans la question 2 on a trouver a et b vu que la fonction et sous forme ax+b 
    t=gener_temp((1/T),NT,1)
    x=(-E/T)*t+E
endfunction
function [x,t]=my_ramp_neg0(t)//cree une rampe qui commence a et se termine a 0 qaund t=1 on l utilise comme raourssi pour cree des rampe
    x=-t+1
endfunction
function [x ,t]= caree(A,F0,Nt,Np,alpha,x0)//cree une fonction caree grace a squarewaves 
    t=gener_temp(F0,Nt,Np)
    //on met le x moyenne du square wave a 0 pour rajouter notre  x moyenne que on veut
    x=2*A*squarewave(2*%pi*F0*t,100*alpha)-A*(2*alpha-1)+x0//alpha c est le rapport cyclique vu c est combien la fonction est positif pa =r exemple alpha = 25 donc pand    ant 25% c est egale a 1 ou plus genre le front montant
    //note: le rapport cyclique change le min et le max  pour garder la meme surface genre si tu change le pourcent de 0.5 a 0.75 max  du graphe change pour avoir la meme surface 
    
endfunction
function [x,t]=my_ramp_neg(E,T,Nt,Np)//on utilise maintenant neg0 pour juste gagner du temp por cree la rampe qui se repete car la rampe de basze sarrete a 1 nous on remplace le 1 par t on multiple par e pour avoir la fonction que on veur comme dans my rampe neg 1
    t=gener_temp(1/T,Nt,Np)
    x=E*my_ramp_neg0(modulo(t/T,1))//on met un module car ca repet vu que si la devision de t/t donne un truce trop petit elle revient a 0
endfunction
/*function [x,t]=somme_cos(a,f,Nt,Np)//a,f sont des vecteur qui contienne les amplitude et fonction
    F0=freq_fondamentale(f)//pour calculer la frequence fondament vu en cour k1/k2=f2/f1.......0
    t=gener_temp(F0,Nt,Np)//pour trouver la frequence commune on a utiliser la methode de cour en mode f1/f2=f3/f2=k2/k1....bla bla rappel toi pour la somme de sin en gros le pcgd
    x=0
    for i= 1:length(a)//pour rajouter autant de cos ou sin que on veut
    x=x+a{i}cos(2*%pi*f(i)*t)//la on a juste ecris la somme
    end 
endfunction*/
function F0=freq_fondamentale(f)
    F0=gcd(f)//on utilse le pgcd pour trouver le plus grand deviseur commun des 3 comme en cour
endfunction
function t=timi()
    t= 0:1/100:40
endfunction
function [x,t]=expt(TO,Td,Tf,Pa)
    t=gener_temps_exp(Td,Tf,Pa)
    if TO==0 then
        disp("non pas de 0 le con")
        x=0
        else
       x=exp(-t/TO)
        end
endfunction
function F0=freq_fondamentale(F)
    F0=gcd(F)
endfunction

function t=genere_temps(F,Np,Nt)
    F0=freq_fondamentale(F)
    Fmax=max(F)
    Nhmax=Fmax/F0
    T0=1/F0
    Tmin=1/Fmax
    Te=T0/(Nhmax*Nt)
    Tv=Np*T0-Te
    t=0:Te:Tv
endfunction

function x=somme_cos(A,F,t)
    x=A*cos(2*%pi*F'*t)
endfunction

function x=somme_sin(A,F,t)
    x=A*sin(2*%pi*F'*t)
endfunction

function x=somme_exp(A,F,t)
    x=A*exp(2*%i*%pi*F'*t)
endfunction

function P=TF_porte(f,T0)
    P=T0*sinc(%pi*f*T0).*exp(-%i*%pi*f*T0)
endfunction

function X=TF_porte_cosinus(f,T0,Fn)
    X=(1/2)*(TF_porte((f-Fn),T0)+TF_porte((f+Fn),T0))
endfunction

function X=TF_porte_sinus(f,T0,Fn)
    X=(-%i/2)*(TF_porte((f-Fn),T0)-TF_porte((f+Fn),T0))
endfunction

function X=TFX(A1,B1,F1,f,T0)
    X=0
    for i=1:length(F1)
        X=X+A1(i)*TF_porte_cosinus(f,T0,F1(i))+B1(i)*TF_porte_sinus(f,T0,F1(i))
    end
endfunction
function t95=tempscaract(t,s)
    s_final = s($)
    s95 = 0.95 * s_final;
    t95 = %nan;
    for i = 1:length(t)
        if s(i) >= s95 then
            t95 = t(i);
            break; 
        end
    end
endfunction
function D= depass(s)
    D=100*(max(s)-s($))/s($)
    
endfunction

