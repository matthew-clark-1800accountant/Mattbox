global class Fake {
    global static String firstName() {
        List<String> firstNames = new List<String>{'Mary','Fiona','Gal','Susan','Maria','Karen','Lisa','Allen','Linda',
                                                    'Donna','Patricia','Nancy','Betty','Helen','Carol','Ruth','Sharon',
                                                    'Sarah','Amy','Anna','Jon','John','Dean','Sam','James','Michael','David',
                                                    'Kevin','Anthony','Gary','Timothy','Jose','Frank','Eric','Jerry','Dennis',
                                                    'Peter', 'Paul','Mark','Donald'};
        
        return firstNames[(Integer)(Math.random()*(firstNames.size() - 1))];
    }

    global static String lastName() {
        List<String> lastNameList = new List<String>{'Smith','Johnson','Williams','Jones','Brown','Gallaghar','Anderson','Thomas',
                                                     'Jackson','White','Martin','Garcia','Martinez','Lee','Walker','Hall','Allen',
                                                     'Young','Hernandez','Lewis','Scott','Green','Adams','Baker'};

        return lastNameList[(Integer)(Math.random()*(lastNameList.size() - 1))];
    }

    global static String companyName() {
        List<String> companyList = new List<String>{'Walmart','Amazon','Samsung','Yum China','Kroger','Home Depot','Berkshire Hathaway',
                                                    'FedEx','United Parcel Service','Target Corporation','General Electric',
                                                    'Walgreens Boots Alliance','Starbucks','Albertsons','PepsiCo','Wells Fargo',
                                                    'McDonald','HCA Healthcare','Aramark','AT&T','J.P. Morgan Chase'};
        
        return companyList[(Integer)(Math.random()*(companyList.size() - 1))];
    }

    global static String productName() {
        List<String> productList = new List<String>{'Business Tax Preparation','Tax Advisory','Personal Tax Preparation','1-800Accountant Access',
                                                    'Payroll services','Bookkeeping','1099 Prep','Additional 1099 Prep',
                                                    'Business Tax Extension','Quarterly Estimated Taxes','State Filing Fee','W2 Preparation'};
        
        return productList[(Integer)(Math.random()*(productList.size() - 1))];
    }
}