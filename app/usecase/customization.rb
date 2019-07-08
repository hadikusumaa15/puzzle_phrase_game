class Customization

    def initialize(params = {})
        @name = params[:name]
        @description = params[:description]
    end
    
    def new_phrase
        phrase = Phrase.new(name: @name, description: @description, deleted: 0)
    end

    def edit_phrase

    end

    def delete_phrase

    end

end
