function BundleUpdateTestForFunction( funct , base_param, exact, round)
fprintf('------------------- Untersuche Funktion: %s -------------------\n\n',funct.name);

paramWithFiFo = copy(base_param);
paramWithFiFo.bundleUpdate = 'fifo'; 

paramWithLE = copy(paramWithFiFo);
paramWithLE.bundleUpdate = 'largest error';

paramWithRandom = copy(paramWithFiFo);
paramWithRandom.bundleUpdate = 'random';

outputProperties = OutputProperties;
outputProperties.allFalse();
outputProperties.printConsecutive = false;
outputProperties.indicateNegativeAlphas = false;



paramWithFiFo.auxRound = false;
paramWithLE.auxRound = false;
paramWithRandom.auxRound = false;
if exact
    [~,~, ~, ~, ~, ~, ~, ~, fifo_errorHistoryValue, fifo_funcCalls, fifo_subgradCalls] = ...
        Tester( funct, paramWithFiFo, outputProperties );

    [~,~, ~, ~, ~, ~, ~, ~, le_errorHistoryValue, le_funcCalls, le_subgradCalls] = ...
        Tester( funct, paramWithLE, outputProperties );

    [~,~, ~, ~, ~, ~, ~, ~, ru_errorHistoryValue, ru_funcCalls, ru_subgradCalls] = ...
        Tester( funct, paramWithRandom, outputProperties );
end
paramWithFiFo.auxRound = true;
paramWithLE.auxRound = true;
paramWithRandom.auxRound = true;
if round
[~,~, ~, ~, ~, ~, ~, ~, round_fifo_errorHistoryValue, round_fifo_funcCalls, round_fifo_subgradCalls] = ...
    Tester( funct, paramWithFiFo, outputProperties );

[~,~, ~, ~, ~, ~, ~, ~, round_le_errorHistoryValue, round_le_funcCalls, round_le_subgradCalls] = ...
    Tester( funct, paramWithLE, outputProperties );

[~,~, ~, ~, ~, ~, ~, ~, round_ru_errorHistoryValue, round_ru_funcCalls, round_ru_subgradCalls] = ...
    Tester( funct, paramWithRandom, outputProperties );
end
if round && exact
    PlotErrors(funct.name, fifo_errorHistoryValue,round_fifo_errorHistoryValue, le_errorHistoryValue,round_le_errorHistoryValue, ru_errorHistoryValue,round_ru_errorHistoryValue)
else
    if exact
        PlotErrors3(funct.name, fifo_errorHistoryValue, le_errorHistoryValue, ru_errorHistoryValue);
    end
    if round
        PlotErrors3(funct.name, round_fifo_errorHistoryValue, round_le_errorHistoryValue, round_ru_errorHistoryValue);    
    end
end



if exact
    fprintf('Funktionsaufrufe bei Fifo:                      %d\n', fifo_funcCalls);
end
if round
    fprintf('Funktionsaufrufe bei Fifo mit Rundung:          %d\n', round_fifo_funcCalls); 
end
if exact
    fprintf('Funktionsaufrufe bei largest error:             %d\n', le_funcCalls); 
end
if round
    fprintf('Funktionsaufrufe bei largest error mit Rundung: %d\n', round_le_funcCalls); 
end
if exact
    fprintf('Funktionsaufrufe bei random:                    %d\n', ru_funcCalls); 
end
if round
    fprintf('Funktionsaufrufe bei random mit Rundung:        %d\n', round_ru_funcCalls); 
end
if exact
    fprintf('Subgradientenauswertungen bei Fifo:                      %d\n', fifo_subgradCalls); 
end
if round
    fprintf('Subgradientenauswertungen bei Fifo mit Rundung:          %d\n', round_fifo_subgradCalls); 
end
if exact
    fprintf('Subgradientenauswertungen bei largest error:             %d\n', le_subgradCalls); 
end
if round
    fprintf('Subgradientenauswertungen bei largest error mit Rundung: %d\n', round_le_subgradCalls); 
end
if exact
    fprintf('Subgradientenauswertungen bei random:                    %d\n', ru_subgradCalls); 
end
if round
    fprintf('Subgradientenauswertungen bei random mit Rundung:        %d\n', round_ru_subgradCalls); 
end

end

