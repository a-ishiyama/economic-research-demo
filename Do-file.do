***Outliers for Income
sum income if sample==1, detail
sum income if income<5210 & sample==1, detail

*** summary statistics
sum satisfaction educational_capital healthcare_capital age income disability health depression sport volunteering hhstructure sex unemployed withoutmorgage if income<5210 & sample==1

***T-test mean comparison
ttest sex, by(treated)
ttest age, by(treated)
ttest income, by(treated)
ttest disability, by(treated)
ttest health, by(treated)
ttest depression, by(treated)
ttest sport, by(treated)
ttest volunteering, by(treated)
ttest unemployed, by(treated)
ttest withoutmorgage, by(treated)

***regression of OLS
reg satisfaction i.educational_capital#i.healthcare_capital age age2 income income2 ageincome i.disability#i.health#i.depression i.sport#i.volunteering i.hhstructure i.sex#i.status i.ownaccommodation i.country if income<5210, robust
predict predicted_satisfaction
sum predicted_satisfaction if income<5210
drop predicted_satisfaction

***regression of ordinal probit
oprobit satisfaction i.educational_capital#i.healthcare_capital age age2 income income2 ageincome i.disability#i.health#i.depression i.sport#i.volunteering i.hhstructure i.sex#i.status i.ownaccommodation i.country if income<5210, robust

***compares the predicted probability of outcome when both education and healthcare capital = 1 or =0
margins, at(educational_capital==1 healthcare_capital==1) predict(outcome(1)) atmeans
margins, at(educational_capital==0 healthcare_capital==0) predict(outcome(1)) atmeans
margins, at(educational_capital==1 healthcare_capital==1) predict(outcome(2)) atmeans
margins, at(educational_capital==0 healthcare_capital==0) predict(outcome(2)) atmeans
margins, at(educational_capital==1 healthcare_capital==1) predict(outcome(3)) atmeans
margins, at(educational_capital==0 healthcare_capital==0) predict(outcome(3)) atmeans
margins, at(educational_capital==1 healthcare_capital==1) predict(outcome(4)) atmeans
margins, at(educational_capital==0 healthcare_capital==0) predict(outcome(4)) atmeans
margins, at(educational_capital==1 healthcare_capital==1) predict(outcome(5)) atmeans
margins, at(educational_capital==0 healthcare_capital==0) predict(outcome(5)) atmeans
margins, at(educational_capital==1 healthcare_capital==1) predict(outcome(6)) atmeans
margins, at(educational_capital==0 healthcare_capital==0) predict(outcome(6)) atmeans
margins, at(educational_capital==1 healthcare_capital==1) predict(outcome(7)) atmeans
margins, at(educational_capital==0 healthcare_capital==0) predict(outcome(7)) atmeans
margins, at(educational_capital==1 healthcare_capital==1) predict(outcome(8)) atmeans
margins, at(educational_capital==0 healthcare_capital==0) predict(outcome(8)) atmeans
margins, at(educational_capital==1 healthcare_capital==1) predict(outcome(9)) atmeans
margins, at(educational_capital==0 healthcare_capital==0) predict(outcome(9)) atmeans
margins, at(educational_capital==1 healthcare_capital==1) predict(outcome(10)) atmeans
margins, at(educational_capital==0 healthcare_capital==0) predict(outcome(10)) atmeans
*** P(Life Satisfaction=x|educational_capital==1 healthcare_capital==1)
***x=1: 0.0061002	x=2: 0.0067617	x=3: 0.0182263	x=4: 0.0272045	x=5 0.119762
***x=6: 0.1192607	x=7: 0.2429047	x=8: 0.2883469	x=9: 0.1049515	x=10: 0.0664816
*** P(Life Satisfaction=x|educational_capital==0 healthcare_capital==0)
***x=1: 0.0108003	x=2: 0.01082	x=3: 0.0272348	x=4: 0.0380139	x=5: 0.1507983	
***x=6: 0.1356198	x=7: 0.2484195	x=8: 0.2547584	x=9: 0.0800403	x=10: 0.0434948

***Endogeneity issues
reg satisfaction i.educational_capital#i.healthcare_capital age age2 income income2 ageincome i.disability#i.health#i.depression i.sport#i.volunteering i.hhstructure i.sex#i.status i.ownaccommodation i.country if income<5210, robust
predict residual, residual
reg educational_capital i.healthcare_capital age age2 income income2 ageincome i.disability#i.health#i.depression i.sport#i.volunteering i.hhstructure i.sex#i.status i.ownaccommodation i.country residual if income<5210, robust
reg healthcare_capital i.educational_capital age age2 income income2 ageincome i.disability#i.health#i.depression i.sport#i.volunteering i.hhstructure i.sex#i.status i.ownaccommodation i.country residual if income<5210, robust

***Robustness Check
reg satisfaction i.educational_capital#i.healthcare_capital age age2 i.disability#i.depression i.sport#i.volunteering i.sex i.country if income<5210, robust
reg satisfaction i.educational_capital#i.healthcare_capital age age2 income income2 ageincome i.disability#i.health#i.depression i.sport#i.volunteering i.hhstructure i.sex#i.status i.ownaccommodation i.country if income<5210 & incomegroup==1, robust
reg satisfaction i.educational_capital#i.healthcare_capital age age2 income income2 ageincome i.disability#i.health#i.depression i.sport#i.volunteering i.hhstructure i.sex#i.status i.ownaccommodation i.country if income<5210 & age>=60, robust
