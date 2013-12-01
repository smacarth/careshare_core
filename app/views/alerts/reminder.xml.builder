xml.instruct!
xml.Response do
    xml.Gather(:action => @post_to, :numDigits => 1) do
        xml.Say "Hello"
        xml.Say @name
        xml.Say "This is a reminder to take your medication."
        xml.Say "Please press 1 if you have taken the medication. Press 2 to be reminded again in 10 minutes."
    end
end