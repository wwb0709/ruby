    require 'builder'   
     
    x = Builder::XmlMarkup.new(:target =>
     $stdout, :indent => 1)  
    #":target =＞$stdout"参数：指示输出内
    
    #":indent =＞1"参数：XML输出形式将被缩
     x.instruct! :xml,
    :version =>'1.1',:encoding => 'gb2312'  
    x.comment! "书本信息"  
     
    x.library("shelf" => "Recent Acquisitions") {  
    x.section("name" => "ruby"){  
    x.book("isbn" => "0672310001"){  
    x.title "Programming Ruby"   
    x.author "Yukihiro "  
    x.description "Programming Ruby - 
    The Pragmatic Programmer's Guide"  
    }  
    }  
    } 
    