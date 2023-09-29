class HomeController < ApplicationController
 
  def index   
  end

  def about
    @about_me = "My name is Ramon"
    #Esta es una variable global que podras usar en todas las paginas de about
    #about_me
    #Pero sin el arroba seria una variable normal solo para usar aqui

    @answer = 2 + 2
  end
end
