%:include<iostream>
%:include<bitset>
%:include<ctime>
%:include<chrono>
%:include<thread>
int main(){std::bitset<800>f;srand(static_cast<unsigned int>(time(nullptr)));for(unsigned int i=0;i<f.size();++i)if(!(rand()%4))f[i]=true;for(;;){std::this_thread::sleep_for(std::chrono::milliseconds(250));std::bitset<800>nf;for(struct{int i,n;}a={0,0};a.i<f.size();++a.i)<%!(a.i%40)? std::cout<<"\n" : f[a.i] ? std::cout<<"#" : std::cout<<" ";a.n+=((a.i>40&&f[a.i-41])+(a.i>39&&f[a.i-40])+(a.i>38&&f[a.i-39])+(a.i>0&&f[a.i-1])+(a.i<799&&f[a.i+1])+(a.i<761&&f[a.i+39])+(a.i<760&&f[a.i+40])+(a.i<759&&f[a.i+41]));a.n<2||a.n>3 ? nf[a.i]=false :(a.n==3)||(f[a.i]==1&&a.n==2)? nf[a.i]=true : true;a.n=0;%>f=nf;}}