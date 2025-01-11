% Nigerian Semi-Structural Model in Dynare
var y pi i exrate oilprice;
varexo eps_y eps_pi eps_i eps_exrate eps_oilprice;

parameters alpha1 alpha2 alpha3 beta1 beta2 beta3 rho phi_pi phi_y gamma1 gamma2 gamma3 delta;

% Parameter values
alpha1 = 0.8;      % Persistence in output
alpha2 = -0.5;     % Interest rate sensitivity of output
alpha3 = 0.2;      % Oil price impact on output
beta1 = 0.7;       % Persistence in inflation
beta2 = 0.3;       % Output gap effect on inflation
beta3 = 0.1;       % Exchange rate pass-through to inflation
rho = 0.8;         % Interest rate smoothing
phi_pi = 1.5;      % Inflation response in Taylor rule
phi_y = 0.5;       % Output gap response in Taylor rule
gamma1 = 0.4;      % External debt effect on exchange rate
gamma2 = -0.2;     % Foreign reserves effect on exchange rate
gamma3 = 0.3;      % Oil price effect on exchange rate
delta = 0.9;       % Persistence in oil prices

model;
    % IS Curve
    y = alpha1*y(-1) + alpha2*(i - pi) + alpha3*oilprice + eps_y;

    % Phillips Curve
    pi = beta1*pi(-1) + beta2*y + beta3*exrate + eps_pi;

    % Taylor Rule
    i = rho*i(-1) + (1-rho)*(phi_pi*pi + phi_y*y) + eps_i;

    % Exchange Rate Equation
    exrate = gamma1*exrate(-1) + gamma3*oilprice + eps_exrate;

    % Oil Price Process (exogenous AR(1))
    oilprice = delta*oilprice(-1) + eps_oilprice;
end;

shocks;
    var eps_y = 0.01;
    var eps_pi = 0.01;
    var eps_i = 0.01;
    var eps_exrate = 0.01;
    var eps_oilprice = 0.02;
end;

initval;
    y = 0;
    pi = 0;
    i = 0.05;       % Initial interest rate
    exrate = 300;   % Initial exchange rate
    oilprice = 60;  % Initial oil price
end;

steady;
stoch_simul(order=1, irf=10, periods=200);
