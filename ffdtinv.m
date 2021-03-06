function mu=ffdtinv(Pf,PsILS)

table=[13.2009, -13.2119, -0.8096, -0.1862;
       13.5300, -13.5549, -0.6293, -0.3638;
	   13.4099, -13.4481, -0.5373, -0.4535;
	   12.6968, -12.7458, -0.5404, -0.4487;
	   12.6739, -12.7359, -0.4739, -0.5134; 
	   11.9977, -12.0686, -0.5035, -0.4827;
	   11.5166, -11.5963, -0.5182, -0.4669;
	   11.2055, -11.2944, -0.5172, -0.4668;
	   10.5497, -10.6443, -0.5710, -0.4124;
	   10.1285, -10.2297, -0.5972, -0.3854];
ind=int16(fix(Pf*1000));
e=table(ind,:);

mu=(e(1)+e(2)*PsILS)/(1+e(3)*PsILS+e(4)*PsILS^2);

if PsILS<0.85
    mu=1e5;
elseif PsILS>=1-Pf
    mu=0;
end

return;