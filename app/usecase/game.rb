class Game

    def initialize(params = {})
        @answer = params[:answer]
    end

    def start_game
        lanjut = true
        points = 0
        kata = kumpulan_kata
        word = ambil_kata(kumpulan_kata)
        shuffled_word = shuffle_word(word)
        value = false

        while lanjut == true
            if value== true
                kata = kata - [word]
                if !kata.empty?
                    word = ambil_kata(kata)
                    shuffled_word = shuffle_word(word)
                else
                    lanjut = false
                end
            end

            if lanjut == true
                soal = soal(shuffled_word)
                puts soal
                answer = get_answer
                value = compare_jawaban(answer,word)
                points = point_sekarang(value, points)
                respon = respon(value, points)
                puts respon
            else
                finish_game(points)
            end
        end
    end

    private

    def available
        {deleted: 0}
    end

    def kumpulan_kata
        words = Phrase.where(available)
        return words
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
        puts "\nPERMAINAN SELESAI!! point anda : #{points}"
    end

end
