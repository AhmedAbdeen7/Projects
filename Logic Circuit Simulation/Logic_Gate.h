//
// Created by Fawzy on 3/7/2024.
//

#ifndef LOGIC_CIRCUIT_SIMULATOR_LOGIC_GATE_H
#define LOGIC_CIRCUIT_SIMULATOR_LOGIC_GATE_H
using namespace std;
#include <string>
#include <vector>
#include <tuple>
#include <map>
#include<unordered_set>
#include <memory>



class Logic_Gate {
private:

    //data from .lib file

    //Name as string from .lib file
    string name;


    //Number of inputs as from .lib file
    int num_Of_Inputs = 0;

    //Delay in picoseconds as in .lib file
    int delay_ps = 0;

    //Expression as in .lib file split into the following format:
    //input, operator, input, operator, input... so the odd index is always an operator
    string expression;



//string is the name from the .cir file and int is initalized to -1 until .stim applies a value then we only run this again if it changes
    //Inputs ust be entered in the same order of inputs as that of the 2D vector theat you read the .cir file with
    vector<pair<string,int>> cir_Input_Names;

    //Name as in .cir file
    string cirCompName;

    string cir_Output_Name;

    //Initialized as 0
    bool cirOutput = 0;

    //Will take the same value as name
    string cirType;

public:


    Logic_Gate()
    {

    }


    Logic_Gate(string name, int num_Of_Inputs, int delay_ps, string expression)
    {
        this->name = name;
        this->num_Of_Inputs = num_Of_Inputs;
        this->delay_ps = delay_ps;
        this->expression = expression;
        cirCompName = "Unnamed";
        cirType = "No Type";
        cir_Output_Name = "no name";

    }

    //Funcitons

    // void sort_Cir_inputs(circuit c);

    std::unordered_set<std::size_t> previousInputHashes;


    // Setters
    void setName(const string& name);

    void setNumOfInputs(int num_Of_Inputs);

    void setDelayPs(int delay_ps);


    void setExpression(const string& expression);

//    void setCirInputs(const vector<tuple<char, bool, int>>& cirInputs) {
    //      this->cirInputs = cirInputs;
    //  }

    void setCirCompName(const string& cirCompName);


    void setCirInputName(string s, int x);

    void setCirOutput(bool cirOutput);

    void setCirType(const string& cirType);

    void setCirOutputName(string cir_Output_Name);

    void set_cir_Input_Names(vector<pair<string, int>> cir_Input_Names);
    // Getters
    string getName() const;

    int getNumOfInputs() const;

    int getDelayPs() const;

    string getExpression() const;



    vector<pair<string,int>> get_cir_Input_Names() const;

    vector<pair<string,int>>& getREF_cir_Input_Names();

    string getCirCompName() const;


    bool getCirOutput() const;

    string getCirType() const;

    string getCirOutputName() const;



};


#endif //LOGIC_CIRCUIT_SIMULATOR_LOGIC_GATE_H
