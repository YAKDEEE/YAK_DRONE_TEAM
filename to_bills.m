function [C] = to_bills(curreny)
%to_bills 이 함수의 요약 설명 위치
%달러, 유로, 엔, 위안을 받아서 화폐를 최소로 만들기



dollar_bills=[100 50 20 10 5 2 1 0 0 0];
euro_bills = [500 200 100 50 20 10 5 2 1 0];
yen_bills=[10000 5000 2000 1000 500 100 50 10 5 1];
yuan_bills=[100 50 20 10 5 1 0 0 0 0];

bills_matrix= [dollar_bills; euro_bills; yen_bills; yuan_bills];
bills_unit=["$","€","¥(Yen)","¥(Yuan)"];

for currency_idx = 1:4
    changed_money=curreny(currency_idx);
    sum = 0;
    for bills_idx = 1:10
        money=bills_matrix(currency_idx,bills_idx);

        if money ~= 0
            if money <= changed_money
               sum= sum+fix(changed_money/money);
               fprintf("%d%s짜리 화폐 : %d개 ",money,bills_unit(currency_idx),fix(changed_money/money));
            end

            changed_money= rem(changed_money,money);
        end
    end
    fprintf("\n총 화폐(%s) 갯수: %d개\n",bills_unit(currency_idx),sum);
end



