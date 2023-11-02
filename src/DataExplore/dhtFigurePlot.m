close all
clear
clc

opts = detectImportOptions('splitted/dht_data.csv');
opts.VariableNamingRule = 'preserve';
data = readtable('splitted/dht_data.csv', opts);

% Name of columns
columns = data.Properties.VariableNames;

% Split columns in bands
num_columns = numel(columns);
num_bands = num_columns / 2;

for band = 1:num_bands
    figure;

    % Plot
    for coluna = 1:2
        subplot(2, 1, coluna);

        % Select column of table
        coluna_atual = data.(columns{(band - 1) * 2 + coluna});

        % Plot TA HVS
        classes = unique(data.zzclassification);
        for i = 1:length(classes)
            classe = classes{i};
            indices = strcmp(data.zzclassification, classe);
            plot(coluna_atual(indices), 'DisplayName', classe);
            xlabel('índice da amostra')
            if coluna == 1
                ylabel('A[i]')
            end
            if coluna == 2
                ylabel('|F[i]|')
            end
            hold on;
        end

        % Add figure texts
        title(columns{(band - 1) * 2 + coluna});
        legend('Location', 'Best');
    end
    % Extract items for file name
    columnName = columns{(band - 1) * 2 + coluna}
    index = strfind(columnName,' - ')
    fileName = columnName(index + 3:end);
    filePath = strcat(strcat('figures/',fileName),'.pdf')

    set(gcf, 'Position', [100, 100, 800, 600]);
    print(filePath, '-dpdf', '-r600');
end
