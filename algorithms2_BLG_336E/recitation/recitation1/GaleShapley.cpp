#include <iostream>
#include <vector>
#include <fstream>

using namespace std;


void GaleShapley(vector<vector <int> > prefHospital, vector<vector <int> > invPrefResident){
    // Get how many free do we have and initialize match lists
    int free = prefHospital.size();
    int n = prefHospital.size();
    vector<int> hospitalMatch(free,-1);
    vector<int> residentMatch(free,-1);
    
    //hospitalMatch --> [4, -1, -1, -1, -1]
    //residentMatch --> [-1, -1, -1, 0, -1]

    int resident;
    int i;

    while(free > 0){
        //Find the first available hospital
        for(i = 0; i < n; i++){
            if(hospitalMatch[i] == -1){
                break;
            }
        }
        
        for(int j=0;j<n;j++){
            //Find the first valid hospital to match
            resident = prefHospital[i][j];
            //If the resident is available, then match them
            if(residentMatch[resident] == -1){
                hospitalMatch[i] = resident;
                residentMatch[resident] = i;
                free--;
                break;
            }
            //If not, compare the preferences of new & old offers
            else{
                // Check indexes of offers from inverse preference list
                if(invPrefResident[resident][i] < invPrefResident[resident][residentMatch[resident]]){
                    hospitalMatch[i] = resident;
                    hospitalMatch[residentMatch[resident]] = -1;
                    residentMatch[resident] = i;
                    break;
                }
            }
        }
        
    }
    cout << "STABLE MATCHING" << endl;
    for(int i = 0; i<n; i++){
        cout << "Hospital: " << i << ", Resident: " << hospitalMatch[i] << endl;
    }
}

void print(vector<vector <int> > p){
    for(int i=0; i<p.size();i++){
        for(int j=0; j<p[i].size();j++){
            cout << p[i][j] << " ";
        }
        cout << endl;
    }
};

int main(){
    ifstream hospitalsFile, residentsFile;
    hospitalsFile.open("hospitals.txt");
    residentsFile.open("residents.txt");
    
    int n;
    int temp;
    hospitalsFile >> n;
    residentsFile >> n;


    vector<int> h, r;
    vector<int> inv_r(n, 0);

    vector<vector <int> > hospitals, residents;
    
    for(int i=0; i<n; i++){
        for(int j=0; j<n; j++){
            hospitalsFile >> temp;
            h.push_back(temp);
            residentsFile >> temp;
            r.push_back(temp);
        }
        hospitals.push_back(h);
        h.clear();
        // We create inverse preference list of residents for constant time access for each preference query
        // index     0  1  2  3  4
        // r     -> [2, 0, 4, 3, 1]
        // inv_r -> [1, 4, 0, 3, 2]
        for(int z=0; z<n; z++)
            inv_r[r[z]] = z;
        residents.push_back(inv_r);
        r.clear();
    }


    GaleShapley(hospitals, residents);
        
    return 0;
}
