function [C] = exchange(won)

A = [won won won won];
exchange_rate = [1229.50 1328.84 972.28 192.62];
C = floor(A ./ exchange_rate);
bills_unit = ["＄","€","￥(Yen)","￥(Yuan)"];

for i = 1:4
    fprintf("%d%s입니다.", C(i), bills_unit(i));
    fprintf("\n");
end