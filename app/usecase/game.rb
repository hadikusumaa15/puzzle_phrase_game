class Game

    def initialize(params = {})
        @answer = params[:answer]
        @word = params[:word]
        @points = params[:points].to_i
        @words = check_words(params)
        @lanjut = check_lanjut(params)           
    end

    def start_game
        response ={}
        lanjut = @lanjut
        points = @points || 0
        words = @words || kumpulan_kata
        word = @word || ambil_kata(kumpulan_kata)
        shuffled_word = shuffle_word(word)
        value = false

            if lanjut == true
                soal = soal(shuffled_word)
                puts soal
                if !@answer.nil?
                    answer = get_answer
                    value = compare_jawaban(answer,word)
                    points = point_sekarang(value, points)
                    respon = respon(value, points)
                end
            else
                respon = finish_game(points)
            end
            
            if value == true
                words = sisa_kata(words, word)
                if !words.empty?
                    word = ambil_kata(words)
                    shuffled_word = shuffle_word(word)
                    soal = soal(shuffled_word)
                else
                    lanjut = false
                    soal = nil
                    respon = finish_game(points)                
                end
            end

            response[:soal] = soal
            response[:respon] = respon
            response[:points] = points
            response[:lanjut] = lanjut
            response[:words] = words.to_s.gsub(" ","")
            response[:word] = word

            return response
    end

    private

    def valid_json(json)
        JSON.parse(json)
        return true
      rescue JSON::ParserError => e
        return false
    end

    def check_words(params)
        if (!params[:words].nil?) && (valid_json(params[:words]))
            words = JSON.parse params[:words]
        else
            words = nil
        end
        return words
    end
    
    def check_lanjut(params)
        if params[:lanjut] == "false"
            lanjut = false
        else
            lanjut = true
        end
        return lanjut    
    end

    def sisa_kata(words, word)
        words = words - [word]
        return words
    end

    def kumpulan_kata
        words = Phrase.where(deleted: false)
        return words.pluck(:name)
    end

    def ambil_kata(words)
        word = words.shuffle.first
        return word
    end

    def shuffle_word(word="")
        shuffled_word = word
        while shuffled_word == word
            shuffled_word = word.split("").shuffle.join("")
        end
        return shuffled_word
    end

    def get_answer
        answer = @answer
        answer = answer.gsub("\n", "")
        return answer
    end

    def soal(shuffled_word)
        soal = "Tebak kata: #{shuffled_word}"
        return soal
    end

    def compare_jawaban(answer, word)
        value = (answer == word)
        return value
    end

    def point_sekarang(value, point)
        if value == true
            point = point + 1
        end
        return point
    end

    def respon(value, points)
        if value == true
            response = "BENAR, point anda : #{points}"
        else
            response = "SALAH! Silakan coba lagi"
        end
        return response
    end

    def finish_game(points)
        return "\nPERMAINAN SELESAI!! point anda : #{points}"
    end

end
