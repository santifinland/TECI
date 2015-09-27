% Function isPrimeSan(n)
%
% Input params:
% - n: number to check whether is prime or not
%
% Output params:
% - prime: boolean. True if n is primer, false otherwise

function p = isPrimeSan(n)
    p = true; 
    % check if n is a multiple of 2
    if ((mod(n, 2) == 0) & (n ~= 2)) p = false;
    % if not, then just check the odds
    else
        for i = 3 : 2 : n - 1
            if (mod(n, i) == 0)
                p = false;
            end
        end
    end
    