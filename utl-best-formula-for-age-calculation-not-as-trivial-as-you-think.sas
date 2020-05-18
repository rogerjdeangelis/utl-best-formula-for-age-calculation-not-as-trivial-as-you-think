Best formula for age calculation not as trivial as you think

Suggestion
   For fractional ages positive or negative use 'act/act' modifier.
   For all other cases use 'age'.

Thanks Quentin
Quentin McMullen <qmcmullen.sas@gmail.com>
added Kreuter macro

The Kreuter macro is a good compromise for non fractional ages.
Because of 'int' function in the macro will not work for fractional ages.
It does not support leap to non-leap ages, If born on 29FEBLEAP increments on 01MARNON-LEAP

 Observations

  1. 'age' modifier increments age on the day of your birthday
      Kreuter macro increments age on the day of your birthday when it exists(exception 29FEB may not exist).
     'act/act' does not always increment on your birthday depends on leap years.

  2. Non Leap:  If born on 29FEB2000, then 'age' modifier will increment age on '28FEB2017' , agrees with US law.
     Leap Year: If born on 29FEB2000, then 'age' modifier will increment age on '29FEB2016', not 28FEB2016.

     If born on 29FEB2000, the Kreuter macro will increment age on '01MAR2017'.
     If born on 29FEB2000, the Kreuter macro will increment age on '29FEB2016' leap year.

  3. Fractional Ages

      Leap Year: Modifier 'age' does not work for fractional ages less than 1, positive or negative. (considers year=365 days)
      Non Leap:  Modifier 'age' does work for fractional ages less than 1, positive or negative. (considers year=365 which is correct)

      Non Leap: Modifier 'act/act' does work for fractional ages, positive or negative (recognizes 366 day years 183/266=.5)

      Kreuter macro does not work for fractional ages, positive or negative (due to int function - suggest change to floor)
      Removing the int helps for fractional ages but I was unable to get it work for all of leap/non leap cases.

This is extremely tricky, be critical of my interpretations?

   Two methodologies
         a. Comparison of yrdif function with 'act/act' and 'age' modifier
         b. December 1993, Billy Kreuter macro
            Quentin McMullen <qmcmullen.sas@gmail.com>
            Does not work


github
https://tinyurl.com/y8bwq3mq
https://github.com/rogerjdeangelis/utl-best-formula-for-age-calculation-not-as-trivial-as-you-think

SAS Forum
https://tinyurl.com/ya7dbfw8
https://communities.sas.com/t5/SAS-Programming/yrdif-function-act-act-vs-age/m-p/648370

Fuzzy defnitions

 a.  In the US, the common law rule is that a year of age is
     completed on the day preceding the anniversary of one's birth.

 b. The law doesn't really distinguish age differences less than a day


ChrisNZ
https://communities.sas.com/t5/user/viewprofilepage/user-id/16961


*                     _      __         _
  __ _      __ _  ___| |_   / /_ _  ___| |_  __   __   __ _  __ _  ___
 / _` |    / _` |/ __| __| / / _` |/ __| __| \ \ / /  / _` |/ _` |/ _ \
| (_| |_  | (_| | (__| |_ / / (_| | (__| |_   \ V /  | (_| | (_| |  __/
 \__,_(_)  \__,_|\___|\__/_/ \__,_|\___|\__|   \_/    \__,_|\__, |\___|
                                  _     _      _   _         _
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

*____   ___   __      _
|___ \ / _ \ / _| ___| |__
  __) | (_) | |_ / _ \ '_ \
 / __/ \__, |  _|  __/ |_) |
|_____|  /_/|_|  \___|_.__/

;

USE AGE

data age v actual modifiers

Note age is not incremented the day before your birthday and
actual age does not agree with age/

data _null_;
    yr_act_act  = floor(yrdif('29FEB2000'd,'28FEB2016'd, 'act/act'));
    yr_age      = floor(yrdif('29FEB2000'd,'28FEB2016'd, 'age'));
put (_all_) (= /);
run;quit;

YR_ACT_ACT   =   17 * you decide
YR_AGE       =   18

*    _               _                                          _
  __| | __ _ _   _  (_)_ __   ___ _ __ ___ _ __ ___   ___ _ __ | |_
 / _` |/ _` | | | | | | '_ \ / __| '__/ _ \ '_ ` _ \ / _ \ '_ \| __|
| (_| | (_| | |_| | | | | | | (__| | |  __/ | | | | |  __/ | | | |_
 \__,_|\__,_|\__, | |_|_| |_|\___|_|  \___|_| |_| |_|\___|_| |_|\__|
             |___/
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
*                           _        _    _
 _ __  _ __ ___ _ __   __ _| |_ __ _| |  | | ___  __ _ _ __
| '_ \| '__/ _ \ '_ \ / _` | __/ _` | |  | |/ _ \/ _` | '_ \
| |_) | | |  __/ | | | (_| | || (_| | |  | |  __/ (_| | |_) |
| .__/|_|  \___|_| |_|\__,_|\__\__,_|_|  |_|\___|\__,_| .__/
|_|                                                   |_|
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

*                           _   _                       _
 _ __  _ __ ___ _ __   __ _| |_| |  _ __   ___  _ __   | | ___  __ _ _ __
| '_ \| '__/ _ \ '_ \ / _` | __| | | '_ \ / _ \| '_ \  | |/ _ \/ _` | '_ \
| |_) | | |  __/ | | | (_| | |_| | | | | | (_) | | | | | |  __/ (_| | |_) |
| .__/|_|  \___|_| |_|\__,_|\__|_| |_| |_|\___/|_| |_| |_|\___|\__,_| .__/
|_|                                                                 |_|
;

data want_prenatal;
  act_act_prenatal = yrdif('02JUL2017'd,'01JAN2017'd, 'ACT/ACT');
  age_prenatal     = yrdif('02JUL2017'd,'01JAN2017'd, 'AGE');
put (_all_) (= /);
run;quit;


'01JAN2017'd - '02JUL2017'd = 182 days = 182/365 = .5 years

ACT_ACT_PRENATAL=-0.498630137
AGE_PRENATAL=-0.498630137

ACT_ACT_PRENATAL   -0.498630137    182/365
AGE_PRENATAL       -0.498630137    182/365



*_        _                   _
| |__    | | ___ __ ___ _   _| |_ ___ _ __    __ _  __ _  ___
| '_ \   | |/ / '__/ _ \ | | | __/ _ \ '__|  / _` |/ _` |/ _ \
| |_) |  |   <| | |  __/ |_| | ||  __/ |    | (_| | (_| |  __/
|_.__(_) |_|\_\_|  \___|\__,_|\__\___|_|     \__,_|\__, |\___|
                                                   |___/
;

%macro utlage (birth,ref)/des="age calculation" ;

  /*Subject: Re: Formula for age calculation in old manuals.
    From: Ian Whitlock <whitloi1@WESTATPO.WESTAT.COM>

    Subject: Re: Formula for age calculation in old manuals.
    Summary: One of the pearls of SAS-L

    Around December 1993, Billy Kreuter gave what I consider the simplest
    most accurate way to calculate age. Here it is as a macro function.

    Ian Whitlock <whitloi1@westat.com>   */

        %* One line exact age calculation due to Billy Kreuter (SAS-L) ;
        %* Use it as function where functions can be used, e.g. DATA step ;
        %*     ex:  age = %age ( birth , today() ) ;

        int((intck('month',&birth,&ref)-(day(&birth)>day(&ref)))/12)

%mend  utlage;

data;
  birth='26SEP1948'd;
  death='06JUL2009'd;
  age=%utlage (birth,death);
  put age=;
run;

*                                _
  __ _  __ _  ___    __ _  ___  / |
 / _` |/ _` |/ _ \  / _` |/ _ \ | |
| (_| | (_| |  __/ | (_| |  __/ | |
 \__,_|\__, |\___|  \__, |\___| |_|
       |___/        |___/
                                 _                       _
  __ _  __ _  ___    __ _  ___  / |  _ __   ___  _ __   | | ___  __ _ _ __
 / _` |/ _` |/ _ \  / _` |/ _ \ | | | '_ \ / _ \| '_ \  | |/ _ \/ _` | '_ \
| (_| | (_| |  __/ | (_| |  __/ | | | | | | (_) | | | | | |  __/ (_| | |_) |
 \__,_|\__, |\___|  \__, |\___| |_| |_| |_|\___/|_| |_| |_|\___|\__,_| .__/
       |___/        |___/                                            |_|
;
Note age is not incremented the day before your birthday and
actual age does not agree with age/

data _null_;
    yr_age      = %utlage('31DEC2000'd,'31DEC2017'd);
put (_all_) (= /);
run;quit;

YR_AGE       =   18  (correct)

*____   ___   __      _
|___ \ / _ \ / _| ___| |__
  __) | (_) | |_ / _ \ '_ \
 / __/ \__, |  _|  __/ |_) |
|_____|  /_/|_|  \___|_.__/

;
data want_leap;
    kreuter_29FEB    = %utlage('29FEB2000'd,'29FEB2016'd);
    kreuter_28FEB    = %utlage('29FEB2000'd,'28FEB2017'd);
    kreuter_01MAR    = %utlage('29FEB2000'd,'01MAR2017'd);
put (_all_) (= /);
run;quit;

KREUTER_28FEB=16  '29FEB2000'd,'29FEB2016'd
KREUTER_28FEB=16  '29FEB2000'd,'28FEB2017'd   * diifers from age

KREUTER_01MAR=17  '29FEB2000'd,'01MAR2017'd   * uses next day


