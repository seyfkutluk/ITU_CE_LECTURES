#include <iostream>
#include <vector>
#include <fstream>

using namespace std;

void GaleShapley(vector<vector <int> > prefhos, vector<vector <int> > invres){

    int free = prefhos.size();
    int n= prefhos.size();
    vector<int> hosmatch(free,-1);
    vector<int> resmatch(free, -1);

    int residents;
    int i;

    while(free>0){
        for(i=0; i<n; i++){
            if(hosmatch[i] == -1){
                break;
            }
        }

        for(int j=0; j<n; j++){

            residents = prefhos[i][j];

            if(resmatch[residents] == -1){
                hosmatch[i]=residents;
                resmatch[residents]=i;
                free--;
                break;
            }

            else{

                if(invres[residents][i] < invres[residents][resmatch[residents]]){
                    hosmatch[i]=residents;
                    hosmatch[resmatch[residents]]= -1;
                    resmatch[residents] =i;
                    break;
                }
            }
        }
    }

    cout<< "STABLE MATCHING" << endl;
    for(int i=0; i<n; i++){
        cout<< "Hospital: " << i << ", Resident "<< hosmatch[i] <<endl;
    }

}

void print(vector< vector <int> > p){
    for(int i=0; i<p.size(); i++){
        for(int j=0; j<p[i].size(); j++){
            cout << p[i][j] << " ";
        }
        cout <<endl;
    }
}

int main(){
    ifstream hospital, residental;
    hospital.open("hospitals.txt");
    residental.open("residents.txt");

    int n;
    int temp;
    hospital >> n;
    residental >> n;
    
    vector<int> h, r;
    vector<int> inv_r(n, 0);

    vector<vector <int> > hospitals, residentals;

    for(int i=0; i<n; i++){
        for(int j=0; j<n; j++){
            hospital >> temp;
            h.push_back(temp);
            residental >>temp;
            r.push_back(temp);
        }
        hospitals.push_back(h);
        h.clear();

        for(int z=0; z<n; z++){
            inv_r[r[z]] = z;
        }
        residentals.push_back(inv_r);
        r.clear();
    }

    GaleShapley(hospitals, residentals);


    return 0;
}