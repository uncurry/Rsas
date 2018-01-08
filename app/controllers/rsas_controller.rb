class RsasController < ApplicationController
  before_action :set_rsa, only: [:show, :edit, :update, :destroy, :encrypt_messages, :decrypt_messages, :show_encrypted ]

  # GET /rsas
  # GET /rsas.json
  def index
    #@rsas = Rsa.all
    @rsa = Rsa.new
    arr_of_vars = get_keys
    @n = arr_of_vars[0]
    @e = arr_of_vars[1]
    @d = arr_of_vars[2]
  end

  # GET /rsas/1
  # GET /rsas/1.json
  def show
  end
  
  def show_encrypted
    @encrypted = Rsa.find(params[:id])
    @enc = @encrypted.encrypt_messages
  end

  # GET /rsas/new
  def new
    @rsa = Rsa.new
    arr_of_vars = get_keys
    @n = arr_of_vars[0]
    @e = arr_of_vars[1]
    @d = arr_of_vars[2]
   # @messages=params['messages']
   # @encrypt_messages = encryptMessage(@messages, @e, @n)
   # @decrypt_messages = decryptMessage(@encrypt_messages, @d, @n)
  end

  # GET /rsas/1/edit
  def edit
    
  end

  # POST /rsas
  # POST /rsas.json
  def create
    @rsa = Rsa.new(rsa_params)
    

    respond_to do |format|
      if @rsa.save
        format.html { redirect_to @rsa, notice: 'Rsa was successfully created.' }
        format.json { render :show, status: :created, location: @rsa }
      else
        format.html { render :new }
        format.json { render json: @rsa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rsas/1
  # PATCH/PUT /rsas/1.json
  def update
    respond_to do |format|
      if @rsa.update(rsa_params)
        format.html { redirect_to @rsa, notice: 'Rsa was successfully updated.' }
        format.json { render :show, status: :ok, location: @rsa }
      else
        format.html { render :edit }
        format.json { render json: @rsa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rsas/1
  # DELETE /rsas/1.json
  def destroy
    @rsa.destroy
    respond_to do |format|
      format.html { redirect_to rsas_url, notice: 'Rsa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def encrypt_messages
    @rsa = Rsa.find(params[:id])
    @messages = params['message']
    @n = @rsa.n.to_i
    @e = @rsa.e.to_i
    @encrypt_messages = encryptMessage(@messages, @e, @n)
  end

  def decrypt_messages
    @rsa = Rsa.find(params[:id])
    @encrypt_messages = params['message']
    @d = @rsa.d.to_i
    @n = @rsa.n.to_i
    @decrypt_messages = decryptMessage(@encrypt_messages, @d, @n)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rsa
      @rsa = Rsa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rsa_params
      params.require(:rsa).permit(:n, :e, :d, :messages, :encrypt_messages, :decrypt_messages)
    end
    
    def get_keys()
    p = get_prime()
    q = get_prime()
    n = p * q
    phi = (p-1)*(q-1)
    e = 65537
    d = get_d(phi, e)
    #m = s_to_n(s)
    #c = encrypt(m, e, n)
    #dec = decrypt(c, d, n)
    #m1 = n_to_s(dec)
    
    [n, e, d]
  end
  
  def encryptMessage (s, e, n)
     m = s_to_n(s)
     c = encrypt(m, e, n)
     c.to_s
  end
  
  def decryptMessage (c, d, n)
    x = c.to_i
    r = decrypt(x, d, n)
    s = n_to_s(r)
    s
  end
  
  
  def encrypt (m, e, n)
    res = mod_pow( m, e, n )
    res
  end

  def decrypt (c, d, n)
     r = mod_pow( c, d, n )
     r
  end
 
  def s_to_n (s)
    n = 0
    s.each_byte{|b|n=n*256+b}
    n
  end
  
  def n_to_s( n )
      s = ""
      while( n > 0 )
        s = ( n & 0xFF ).chr + s
        n >>= 8
      end
      s
  end

  def mod_pow( m, e, n )
     res = 1
     while e > 0     
        res = (res * m) % n if e & 1 == 1
       m = m ** 2 % n
       e >>= 1
     end
     res
  end
  
 
  def extended_gcd( a, b )
      return [0,1] if a % b == 0
      x, y = extended_gcd( b, a % b )
      [y, x - y * (a / b)]
  end

  def get_d(phi, e)
      x, y = extended_gcd( e, phi ) 
      x += phi if x < 0
      x
  end
  
  def get_prime ()
     a = [ 115225284876568243449836733318187827406288693324078818614904121630370852202637,
           111542103949984299962875635313942146125567400652430155876217670985714248562757,
           103422034361856108403826319929624480957976931836360250888117320568473095457287,
           69903362006280506951922264304609615069965899800436649524851354301550361147891,
           91352481246550894739815950439459678379257055722541609290317815338972045504801 ]
     i = rand(0..4)
     pr = a[i]
     pr
  end
end
