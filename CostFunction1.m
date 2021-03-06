function Cost = CostFunction1(x)
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
result_operational_emission=[0,0,0,0,0,0,0,0,0];
result_carbon_emission=[0,0,0,0,0,0,0,0,0];
result_operational_emission1=[0,0,0,0,0,0,0,];
result_carbon_emission1=[0,0,0,0,0,0,0,];
k=1;                                        %Loop variable
sigma = 35;                                 %Constant variance
Dbi=[];                                     %Demand of the plant from supplier
V = [0,0,0];
b = [2,1,2,1]; 
M=400
V(1) = sigma*Y*b(1)*b(1);                   %Calculation of variance from constraint 18
V(2) = sigma*Y*(b(2)*b(2)+b(3)*b(3));
V(3) = sigma*Y*b(4)*b(4);
d1 = fb(1)*x + sqrt(2*HCbi(1,1)*OCbi(1,1))*sqrt(Dbi(1))+HCbi(1,1)*Zalpha*sqrt(LT)*sqrt(V(1)) + M*HCcp(1,1)+ QRcbpt*Cbpt(1)+QOcbpt*Ccpbt(1)+ TCbai(1,1)*Dbi*Z + TCcbp(1,1)*M*Y;
d2 = fb(2)*x + sqrt(2*HCbi(1,2)*OCbi(1,2))*sqrt(Dbi(2))+ sqrt(2*HCbi(2,2)*OCbi(2,2))*sqrt(Dbi(2))+HCbi(1,2)*Zalpha*sqrt(LT)*sqrt(V(2)) +HCbi(2,2)*Zalpha*sqrt(LT)*sqrt(V(2))+ M*HCcp(2,2)+ QRcbpt*Cbpt(2)+QOcbpt*Ccpbt(2)+ TCbai(1,2)*Dbi*Z +TCbai(2,2)*Dbi*Z+ TCcbp(2,2)*M*Y ;
d3 = fb(1)*x +fb(3)*x + sqrt(2*HCbi(1,1)*OCbi(1,1))*sqrt(Dbi(1))+sqrt(2*HCbi(2,3)*OCbi(2,3))*sqrt(Dbi(3))+HCbi(1,1)*Zalpha*sqrt(LT)*sqrt(V(1)+V(3)) +HCbi(2,3)*Zalpha*sqrt(LT)*sqrt(V(1)+V(3)) + M*HCcp(1,3)+M*HCcp(3,3)+ QRcbpt*Cbpt(1)+QOcbpt*Ccpbt(1)+QRcbpt*Cbpt(3)+QOcbpt*Ccpbt(3)+ TCbai(1,1)*Dbi*Z + TCbai(2,3)*Dbi*Z+ TCcbp(1,3)*M*Y+ TCcbp(3,3)*M*Y;
d4 = fb(3)*x + sqrt(2*HCbi(2,3)*OCbi(2,3))*sqrt(Dbi(3))+HCbi(2,3)*Zalpha*sqrt(LT)*sqrt(V(3)) + M*HCcp(3,4)+ QRcbpt*Cbpt(3)+QOcbpt*Ccpbt(3)+ TCbai(2,3)*Dbi*Z + TCcbp(3,4)*M*Y;
y1 = min(d1+d2+d3+d4);
Cost(x);
end

