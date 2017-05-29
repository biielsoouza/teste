file = File.open('log.txt')

hash_urls = {}
hash_status = {}

file.each_line do |line|

  colunas = line.split(" ")

  colunas.each do |coluna|
    coluna_sem_aspas = coluna.gsub(/[\\\"]/, "") # remove as aspas dos valores depois do sinal de igual pra montar o hash mais bonitinho

    if coluna_sem_aspas.start_with? "request_to"
      url = coluna_sem_aspas.split("=").last # split retorna um array, assim: ["request_to", "http://url.com"], aí pega só o último valor

      if hash_urls[url].nil? # verifica se tem algum valor na chave do hash
        hash_urls[url] = 1 # se não tiver valor, inicia com 1
      else
        hash_urls[url] += 1 # se já tiver um valor, adiciona 1
      end

    elsif coluna_sem_aspas.start_with? "response_status"
      status = coluna_sem_aspas.split("=").last

      if hash_status[status].nil?
        hash_status[status] = 1
      else
        hash_status[status] += 1
      end
    end
  end

end

puts "=========================================================================================="
puts hash_urls.sort_by { |k, v| v }.reverse.first(3).to_h # pega o hash e organiza pelos valors, aí inverte o hash, pega os 3 primeiros elementos e transforma em hash de novo pro puts ficar bonitinho 
puts hash_status.sort_by { |k, v| v }.reverse.first(3).to_h
puts "=========================================================================================="