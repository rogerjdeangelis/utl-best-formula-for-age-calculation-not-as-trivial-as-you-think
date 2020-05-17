# utl-best-formula-for-age-calculation-not-as-trivial-as-you-think
Best formula for age calculation not as trivial as you think
    This is extremely tricky be critical of my interpretations?                                                        
                                                                                                                       
    github                                                                                                             
    https://tinyurl.com/y8bwq3mq                                                                                       
    https://github.com/rogerjdeangelis/utl-best-formula-for-age-calculation-not-as-trivial-as-you-think                
                                                                                                                       
    SAS Forum                                                                                                          
    https://tinyurl.com/ya7dbfw8                                                                                       
    https://communities.sas.com/t5/SAS-Programming/yrdif-function-act-act-vs-age/m-p/648370                            
                                                                                                                       
    Generally the 'age' modifier is better than 'act'.                                                                 
    'age' handles leap years. However for fractional and prenat use 'act/act';                                         
                                                                                                                       
    Generally 'act' modifier is better for prenatal or fractional age?                                                 
                                                                                                                       
    Fuzzy defnitions                                                                                                   
                                                                                                                       
     a.  In the US, the common law rule is that a year of age is                                                       
         completed on the day preceding the anniversary of one's birth.                                                
                                                                                                                       
     b. The law doesn't really distinguish age differences less than a day                                             
                                                                                                                       
     e. Be careful using the SAS age modifier for negative ages (prenatal)                                             
        Modifier 'act' seems better then 'age' modifier?                                                               
                                                                                                                       
     e. Be careful using the SAS age modifier for fractional years                                                     
        Modifier 'act' seems better then 'age' modifier?                                                               
                                                                                                                       
     f. If born on a 29th of February the 'age' modifier increments age on the 28 of February                          
        for non leap AND LEAP YEARS..                                                                                  
                                                                                                                       
     h. 'ACT/ACT'  uses the actual number of days between dates in calculating the number of years.                    
        SAS calculates this value as the number of days that fall in 365-day years divided by 365 plus                 
        the number of days that fall in 366-day years divided by 366.                                                  
                                                                                                                       
    ChrisNZ                                                                                                            
    https://communities.sas.com/t5/user/viewprofilepage/user-id/16961                                                  
                                                                                                                       
    *                                 _     _      _   _         _                                                     
      __ _  __ _  ___    ___  _ __   | |__ (_)_ __| |_| |__   __| | __ _ _   _                                         
     / _` |/ _` |/ _ \  / _ \| '_ \  | '_ \| | '__| __| '_ \ / _` |/ _` | | | |                                        
    | (_| | (_| |  __/ | (_) | | | | | |_) | | |  | |_| | | | (_| | (_| | |_| |                                        
     \__,_|\__, |\___|  \___/|_| |_| |_.__/|_|_|   \__|_| |_|\__,_|\__,_|\__, |                                        
           |___/                                                         |___/                                         
    ;                                                                                                                  
                                                                                                                       
    USE AGE                                                                                                            
                                                                                                                       
    data age v actual modifiers                                                                                        
                                                                                                                       
    Note age is not incremented the day before your birthday and                                                       
    actual age does not agree with age/                                                                                
                                                                                                                       
    data _null_;                                                                                                       
        yr_act_act  = floor(yrdif('31DEC2000'd,'31DEC2018'd, 'act/act'));                                              
        yr_age      = floor(yrdif('31DEC2000'd,'31DEC2018'd, 'age'));                                                  
    put (_all_) (= /);                                                                                                 
    run;quit;                                                                                                          
                                                                                                                       
    YR_ACT_ACT   =   17                                                                                                
    YR_AGE       =   18 * commonly used age (use age modifier)                                                         
                                                                                                                       
    *_                                                                                                                 
    | | ___  __ _ _ __     __ _  __ _  ___                                                                             
    | |/ _ \/ _` | '_ \   / _` |/ _` |/ _ \                                                                            
    | |  __/ (_| | |_) | | (_| | (_| |  __/                                                                            
    |_|\___|\__,_| .__/   \__,_|\__, |\___|                                                                            
                 |_|            |___/                                                                                  
    ;                                                                                                                  
                                                                                                                       
    * For leap year dfference less than one use act/act?                                                               
    Probably best to use act/act for any year difference less than 1.                                                  
                                                                                                                       
    'act/Act'   In fractional leap years, date differences are divided by 366 and                                      
                in non leap years the date difference is divided by 365                                                
                                                                                                                       
    data want_leap;                                                                                                    
        act_act_yr           = yrdif('01JAN2000'd,'02JAN2000'd, 'act/act');  * actual year length is 366;              
        act_act_yr_fraction  = 1/366;                                                                                  
        age_yr               = yrdif('01JAN2000'd,'02JAN2000'd, 'age');                                                
        age_yr_fraction      = 1/365;                                                                                  
    put (_all_) ( /);                                                                                                  
    run;quit;                                                                                                          
                                                                                                                       
    data d;                                                                                                            
    d=-'01JAN2000'd+'02JAN2000'd;                                                                                      
    put d=;                                                                                                            
    run;quit;                                                                                                          
                                                                                                                       
                                                                                                                       
    01JAN2000  - 02JAV2000   ( 1 day )                                                                                 
                                                                                                                       
                         Fraction                                                                                      
                          of year                                                                                      
    ACT/ACT                                                                                                            
    =======                                                                                                            
                                                                                                                       
    ACT_ACT_YR          =0.002732  1/366                                                                               
    ACT_ACT_YR_FRACTION =0.002732                                                                                      
                                                                                                                       
    AGE                                                                                                                
    ===                                                                                                                
                                                                                                                       
    AGE_YR              =0.002740  1/365                                                                               
    AGE_YR_FRACTION     =0.002740                                                                                      
                                                                                                                       
    *                           _        _                                                                             
     _ __  _ __ ___ _ __   __ _| |_ __ _| |                                                                            
    | '_ \| '__/ _ \ '_ \ / _` | __/ _` | |                                                                            
    | |_) | | |  __/ | | | (_| | || (_| | |                                                                            
    | .__/|_|  \___|_| |_|\__,_|\__\__,_|_|                                                                            
    |_|                                                                                                                
    ;                                                                                                                  
                                                                                                                       
    * Use act/act for prenatal?                                                                                        
                                                                                                                       
    data want_prenatal;                                                                                                
      act_act_prenatal = yrdif('02JUL2016'd,'01JAN2016'd, 'ACT/ACT');                                                  
      age_prenatal     = yrdif('02JUL2016'd,'01JAN2016'd, 'AGE');                                                      
    put (_all_) (= /);                                                                                                 
    run;quit;                                                                                                          
                                                                                                                       
                                                                                                                       
    '01JAN2016'd - '02JUL2016'd = 183 days = 183/366 = .5 years                                                        
                                                                                                                       
    ACT_ACT_PRENATAL   -0.5           183/366   * more reasonable                                                      
    AGE_PRENATAL       -0.498630137   182/365   * 29FEB left out and year considered to be 365?                        
                                                                                                                       
                                                                                                                       
                                                                                                                       
