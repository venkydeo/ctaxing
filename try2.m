cons = [0,0,0,0,0,0,0,0,0,0,0,0,0,0];
 
 
 
fb=[20,40,50];                                %Fixed cost of the plant
HCbi = [0.3 0.5 0;0 0.4 0.3];                 %Unit Inventory holding cost
OCbi = [25 30 0;0 35 20];                     %Ordering cost
HCcp = [0.3 0 0.4 0;0 0.2 0 0;0 0 0.3 0.5];   %Unit Inventory holding cost
Cbpt = [2,3,4];                               %Cost of regular time production
Ccpbt = [3,6,7.5];                            %Cost of over-time production
TCbai = [0.2 0.1 0;0 0.3 0.3];                %Transportation cost from supplier to plant
TCcbp = [0.1 0 0.3 0;0 0.2 0 0;0 0 0.2 0.1];  %Transportation cost from supplier to plant
 
Z = 1;                                        %Decision variables
Y = 1;
X = 1;
 
LT = 7;                                     %Lead time is 1 week
EMF = [30,40,50];                           %Fixed emission due to manufacturing
EMV = [3,4,5];                              %Variable emission due to manufacturing
EOFia = [40 35 0;0 50 45];                  %Fixed emission due to transportation(from supplier to plant)
EOVia = [2.5 3 0;0 4 3.5];                  %Variable emission due to transportation(from supplier to plant)
EOFpb = [20 0 30 0;0 40 0 0;0 0 45 50];     %Fixed emission due to transportation(from plant to warehouse)
EOVpb = [1.5 0 1 0;0 2 0 0;0 0 3 2.5];      %Variable emission due to transportation(from plant to warehouse)
EIpb = [1.5 1.2 0;0 1.3 1.4];               %Emission due to inventory at plants
EIpc = [1.3 0 1.4 0;0 1.2 0 0;0 0 1.3 1.5]; %Emission due to inventory at warehouse
 
 
Zalpha=1.95;
%Zbai=[1,1,0;0,1,1];
result_operational_emission=[0,0,0,0,0,0,0,0,0];
result_carbon_emission=[0,0,0,0,0,0,0,0,0];
result_operational_emission1=[0,0,0,0,0,0,0,];
result_carbon_emission1=[0,0,0,0,0,0,0,];
 
 
k=1;                                        %Loop variable
sigma = 35;                                 %Constant variance
Dbi=[];                                     %Demand of the plant from supplier
V = [0,0,0];
b = [2,1,2,1]; 
 
 
%M=200;                                      
%Dbi(1) = M*1*b(1);                          %Calculation of demand by plants from supplier using constraint 17
%Dbi(2) = M*1*b(2)+M*1*b(3);
%Dbi(3) = M*1*b(4);
 
V(1) = sigma*Y*b(1)*b(1);                   %Calculation of variance from constraint 18
V(2) = sigma*Y*(b(2)*b(2)+b(3)*b(3));
V(3) = sigma*Y*b(4)*b(4);
 
fprintf('TABLE 1\nMean demand changes from 200 to 600 with constant variance of 35\n');
fprintf('Z1\t\t\t\tZ2\n');
%Mean demand changes from 200 to 600 with constant variance of 35
for M=200:50:600
 
    
    Dbi(1) = M*1*b(1);                          %Calculation of demand by plants from supplier using constraint 17
    Dbi(2) = M*1*b(2)+M*1*b(3);
    Dbi(3) = M*1*b(4);
 
  QRcbpt = M;
  if(QRcbpt>550)
      ORcbpt = 550;
      QOcbpt = M-QRcbpt;
  else
      QOcbpt = 0;
      QRcbpt = M;
  end
  
  d1 = fb(1)*X + sqrt(2*HCbi(1,1)*OCbi(1,1))*sqrt(Dbi(1))+HCbi(1,1)*Zalpha*sqrt(LT)*sqrt(V(1)) + M*HCcp(1,1)+ QRcbpt*Cbpt(1)+QOcbpt*Ccpbt(1)+ TCbai(1,1)*Dbi*Z + TCcbp(1,1)*M*Y;
 
  d2 = fb(2)*X + sqrt(2*HCbi(1,2)*OCbi(1,2))*sqrt(Dbi(2))+ sqrt(2*HCbi(2,2)*OCbi(2,2))*sqrt(Dbi(2))+HCbi(1,2)*Zalpha*sqrt(LT)*sqrt(V(2)) +HCbi(2,2)*Zalpha*sqrt(LT)*sqrt(V(2))+ M*HCcp(2,2)+ QRcbpt*Cbpt(2)+QOcbpt*Ccpbt(2)+ TCbai(1,2)*Dbi*Z +TCbai(2,2)*Dbi*Z+ TCcbp(2,2)*M*Y ;
 
  d3 = fb(1)*X +fb(3)*X + sqrt(2*HCbi(1,1)*OCbi(1,1))*sqrt(Dbi(1))+sqrt(2*HCbi(2,3)*OCbi(2,3))*sqrt(Dbi(3))+HCbi(1,1)*Zalpha*sqrt(LT)*sqrt(V(1)+V(3)) +HCbi(2,3)*Zalpha*sqrt(LT)*sqrt(V(1)+V(3)) + M*HCcp(1,3)+M*HCcp(3,3)+ QRcbpt*Cbpt(1)+QOcbpt*Ccpbt(1)+QRcbpt*Cbpt(3)+QOcbpt*Ccpbt(3)+ TCbai(1,1)*Dbi*Z + TCbai(2,3)*Dbi*Z+ TCcbp(1,3)*M*Y+ TCcbp(3,3)*M*Y;
 
  d4 = fb(3)*X + sqrt(2*HCbi(2,3)*OCbi(2,3))*sqrt(Dbi(3))+HCbi(2,3)*Zalpha*sqrt(LT)*sqrt(V(3)) + M*HCcp(3,4)+ QRcbpt*Cbpt(3)+QOcbpt*Ccpbt(3)+ TCbai(2,3)*Dbi*Z + TCcbp(3,4)*M*Y;
 
  y1 = d1+d2+d3+d4; 
  
  
  d1_2 = EMF(1)*X + EMV(1)*(QRcbpt+QOcbpt)+EOFpb(1,1)*Y + EOVpb(1,1)*M+ EOFia(1,1)*Z + EOVia(1,1)*Dbi(1)+EIpc(1,1)*M+EIpb(1,1)*Zalpha*sqrt(LT)*sqrt(V(1));      
 
  d2_2 = EMF(2)*X + EMV(2)*(QRcbpt+QOcbpt)+EOFpb(2,2)*Y + EOVpb(2,2)*M+ (EOFia(1,2)+EOFia(2,2))*Z + EOVia(1,2)*Dbi(2)+EOVia(2,2)*Dbi(2)+EIpc(2,2)*M + (EIpb(1,2)+EIpb(2,2))*Zalpha*sqrt(LT)*sqrt(V(2));
 
  d3_2 = EMF(1)*X+EMF(3)*X + (EMV(1)+EMV(3))*(QRcbpt+QOcbpt)+(EOFpb(1,3)+EOFpb(3,3))*Y + (EOVpb(1,3)+EOVpb(3,3))*M+ (EOFia(1,1)+EOFia(2,3))*Z + (EOVia(1,1)+EOVia(2,3))*Dbi(1)+(EOVia(1,1)+EOVia(2,3))*Dbi(3)+EIpc(1,1)*M+ (EIpb(1,1)+EIpb(2,3))*Zalpha*sqrt(LT)*sqrt(V(1)+V(3)); 
 
  d4_2 = EMF(3)*X + EMV(3)*(QRcbpt+QOcbpt)+EOFpb(3,4)*Y + EOVpb(3,4)*M+ EOFia(2,3)*Z + EOVia(2,3)*Dbi(3)+EIpc(3,4)*M+EIpb(2,3)*Zalpha*sqrt(LT)*sqrt(V(3));   
  
  y2 = d1_2+d2_2+d3_2+d4_2;
  
  result_operational_emission(k) = min(y1);
  result_carbon_emission(k) = min(y2);
  k=k+1;
  fprintf('%.2f\t\t\t%.2f',min(y1),min(y2));
  fprintf('\n');
end
% 
%----------Plotting of graph--------------------
Mu = [200 250 300 350 400 450 500 550 600];
figure
hold on
%plot3(Mu,result_operational_emission,result_carbon_emission)
[haX,Line1,Line2] = plotyy(Mu,result_operational_emission,Mu,result_carbon_emission);
title('Varying demand and fixed variance');
xlabel('(\mu)');
ylabel(haX(2),'Total carbon emissions')       % right y-axis
ylabel(haX(1),'Total Operational Cost')       % left y-axis 
legend('Total Operational Cost','Total carbon emissions','Location','southeast');
hold off
%------------------------------------------------
 
 
l=1;                                          %Loop variable
M=400;                                        %Constant demand
QRcbpt = M;                                   %Initializing quantity in regular time
QOcbpt = 0;                                   %Initializing quantity in over time
Dbi(1) = M*1*b(1);                            %Calculation of demand by plants from supplier using constraint 17
Dbi(2) = M*1*b(2)+M*1*b(3);
Dbi(3) = M*1*b(4);
 
 
fprintf('\n\n');
fprintf('TABLE 2\nMean demand is constant at 400 and variance varies from 10 to 40\n');
fprintf('Z1\t\t\t\tZ2\n');
%Mean demand is constant at 400 and variance varies from 10 to 40
for sigma=10:5:40
    
    V = [0,0,0];
    V(1) = sigma*Y*b(1)*b(1);
    V(2) = sigma*Y*(b(2)*b(2)+b(3)*b(3));
    V(3) = sigma*Y*b(4)*b(4);
    
    
    
  d1 = fb(1)*X + sqrt(2*HCbi(1,1)*OCbi(1,1))*sqrt(Dbi(1))+HCbi(1,1)*Zalpha*sqrt(LT)*sqrt(V(1)) + M*HCcp(1,1)+ QRcbpt*Cbpt(1)+QOcbpt*Ccpbt(1)+ TCbai(1,1)*Dbi*Z + TCcbp(1,1)*M*Y;
 
  d2 = fb(2)*X + sqrt(2*HCbi(1,2)*OCbi(1,2))*sqrt(Dbi(2))+ sqrt(2*HCbi(2,2)*OCbi(2,2))*sqrt(Dbi(2))+HCbi(1,2)*Zalpha*sqrt(LT)*sqrt(V(2)) +HCbi(2,2)*Zalpha*sqrt(LT)*sqrt(V(2))+ M*HCcp(2,2)+ QRcbpt*Cbpt(2)+QOcbpt*Ccpbt(2)+ TCbai(1,2)*Dbi*Z +TCbai(2,2)*Dbi*Z+ TCcbp(2,2)*M*Y ;
 
  d3 = fb(1)*X +fb(3)*X + sqrt(2*HCbi(1,1)*OCbi(1,1))*sqrt(Dbi(1))+sqrt(2*HCbi(2,3)*OCbi(2,3))*sqrt(Dbi(3))+HCbi(1,1)*Zalpha*sqrt(LT)*sqrt(V(1)+V(3)) +HCbi(2,3)*Zalpha*sqrt(LT)*sqrt(V(1)+V(3)) + M*HCcp(1,3)+M*HCcp(3,3)+ QRcbpt*Cbpt(1)+QOcbpt*Ccpbt(1)+QRcbpt*Cbpt(3)+QOcbpt*Ccpbt(3)+ TCbai(1,1)*Dbi*Z + TCbai(2,3)*Dbi*Z+ TCcbp(1,3)*M*Y+ TCcbp(3,3)*M*Y;
 
  d4 = fb(3)*X + sqrt(2*HCbi(2,3)*OCbi(2,3))*sqrt(Dbi(3))+HCbi(2,3)*Zalpha*sqrt(LT)*sqrt(V(3)) + M*HCcp(3,4)+ QRcbpt*Cbpt(3)+QOcbpt*Ccpbt(3)+ TCbai(2,3)*Dbi*Z + TCcbp(3,4)*M*Y;
 
  y1 = d1+d2+d3+d4;  
  
  
  d1_2 = EMF(1)*X + EMV(1)*(QRcbpt+QOcbpt)+EOFpb(1,1)*Y + EOVpb(1,1)*M+ EOFia(1,1)*Z + EOVia(1,1)*Dbi(1)+EIpc(1,1)*M+EIpb(1,1)*Zalpha*sqrt(LT)*sqrt(V(1));      
 
  d2_2 = EMF(2)*X + EMV(2)*(QRcbpt+QOcbpt)+EOFpb(2,2)*Y + EOVpb(2,2)*M+ (EOFia(1,2)+EOFia(2,2))*Z + EOVia(1,2)*Dbi(2)+EOVia(2,2)*Dbi(2)+EIpc(2,2)*M + (EIpb(1,2)+EIpb(2,2))*Zalpha*sqrt(LT)*sqrt(V(2));
 
  d3_2 = EMF(1)*X+EMF(3)*X + (EMV(1)+EMV(3))*(QRcbpt+QOcbpt)+(EOFpb(1,3)+EOFpb(3,3))*Y + (EOVpb(1,3)+EOVpb(3,3))*M+ (EOFia(1,1)+EOFia(2,3))*Z + (EOVia(1,1)+EOVia(2,3))*Dbi(1)+(EOVia(1,1)+EOVia(2,3))*Dbi(3)+EIpc(1,1)*M+ (EIpb(1,1)+EIpb(2,3))*Zalpha*sqrt(LT)*sqrt(V(1)+V(3)); 
 
  d4_2 = EMF(3)*X + EMV(3)*(QRcbpt+QOcbpt)+EOFpb(3,4)*Y + EOVpb(3,4)*M+ EOFia(2,3)*Z + EOVia(2,3)*Dbi(3)+EIpc(3,4)*M+EIpb(2,3)*Zalpha*sqrt(LT)*sqrt(V(3));   
  
  y2 = d1_2+d2_2+d3_2+d4_2;
  result_operational_emission1(l) = min(y1);
  result_carbon_emission1(l) = min(y2);
  l=l+1;
 
  fprintf('%.2f\t\t\t%.2f',min(y1),min(y2));
  fprintf('\n');
  
end
 
%-----------Plotting of graph--------------------
sigma = [10,15,20,25,30,35,40];
figure
hold on
[haX,Line1,Line2] = plotyy(sigma,result_operational_emission1,sigma,result_carbon_emission1);
title('Fixed demand and variable Variance');
xlabel('(\sigma)');
ylabel(haX(1),'Total Operational Cost')       % left y-axis 
ylabel(haX(2),'Total carbon emissions')       % right y-axis
legend('Total Operational Cost','Total carbon emissions','Location','southeast');
hold off
%------------------------------------------------
 
 
%For finding graph for total cost vs cap and trade (for varying tau)
Ccap = 40000;
tax = [25,30,35,40,45,50];
total_cost = [0,0,0,0,0,0];
cap_trade = [0,0,0,0,0,0];
for i=1:6
    total_cost(i) = result_operational_emission(i)+tax(i)*(result_carbon_emission(i)/1000);
    if(result_carbon_emission(i)>Ccap)
        cap_trade(i) = result_operational_emission(i)+((result_carbon_emission(i)-Ccap)/1000)*tax(i);
    else
        cap_trade(i) = result_operational_emission(i)+((Ccap - result_carbon_emission(i))/1000)*tax(i);
    end
end
figure
hold on
[haX,Line1,Line2] = plotyy(tax,total_cost,tax,cap_trade);
title('Tax vs Cap and Trade');
xlabel('(\tau)');
ylabel(haX(1),'Carbon taxing')          % left y-axis 
ylabel(haX(2),'Cap and Trade')       % right y-axis
legend('Carbon taxing','Cap and Trade','Location','northeast');
hold off
 
%For finding graph fpr strict capping vs Cap and trade (for varying carbon cap)
fine_cap = [0,0,0,0,0,0,0];
Ccap = [30000,32500,35000,37500,40000,42500,45000];                             
for i=1:7 
    if(result_carbon_emission(i)>Ccap(i))
      fine_cap(i) = result_operational_emission(i)+150*((result_carbon_emission(i)-Ccap(i))/1000);
    else 
      fine_cap(i) = result_operational_emission(i)+150*((Ccap(i)-result_carbon_emission(i))/1000); 
    end
    if(result_carbon_emission(i)>Ccap(i))
        cap_trade(i) = result_operational_emission(i)+((result_carbon_emission(i)-Ccap(i))/1000)*35;
    else
        cap_trade(i) = result_operational_emission(i)+((Ccap(i) - result_carbon_emission(i))/1000)*35;
    end
end
 
figure
hold on
[haX,Line1,Line2] = plotyy(Ccap,fine_cap,Ccap,cap_trade);
title('Strict Cap Vs Cap and Trade');
xlabel('Carbon capping');
ylabel(haX(1),'Strict Capping')       % left y-axis 
ylabel(haX(2),'Cap and Trade')        % right y-axis
legend('Strict Capping','Cap and Trade','Location','northeast');
hold off
