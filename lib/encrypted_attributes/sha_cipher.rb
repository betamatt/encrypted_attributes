module EncryptedAttributes
  # Adds support for embedding salts in the encrypted value
  class ShaCipher < EncryptedStrings::ShaCipher
    # Encrypts a string using a Secure Hash Algorithm (SHA), specifically SHA-1.
    # 
    # Configuration options:
    # * <tt>:salt</tt> - Random bytes used as one of the inputs for generating
    #   the encrypted string
    # * <tt>:embed_salt</tt> - Whether to embed the salt directly within the
    #   encrypted value.  Default is false.  This is useful for storing both
    #   the salt and the encrypted value in the same attribute.
    def initialize(value, options = {}) #:nodoc:
      if @embed_salt = options.delete(:embed_salt)
        # The salt is at the end of the value
        salt = value[40..-1]
        options[:salt] = salt unless salt.blank?
      end
      
      super(options)
    end
    
    # Encrypts the data, embedding the salt at the end of the string if
    # configured to do so
    def encrypt(data)
      encrypted_data = super
      encrypted_data << salt if @embed_salt
      encrypted_data
    end
  end
end
