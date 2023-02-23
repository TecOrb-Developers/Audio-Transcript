#Project Title 
   ##Audio Video Transcript
   
#Motivation
  ## This demo app incrased learning and reading efficiency with video and audio content with less effort of reading with highlighted text.

#Build Status
  ## This app continue work enhancement of reader functionality with audio and video, As well as any suggestion and solution will be appreciated

#Code Style
  ## For This transcript demo uses BMPlayer framework , On This framework ever audio or video are played, for using this library
  ### This app has written in Swift 5.0
  ### Xcode Version - 14.0.1
  ### IOS Version - All Suported Version
  

#Screenshots

  ##image and screenshots not uploaded yet

#Tech/Framework used
  ## BMPlayer Library used in this regarding library added, this Library has parent class AVFoundation.
     pod 'BMPlayer' 
  ## Inside App Highlighted text return from source SRT File added inside BMPlayer.   

#Features
  ##1. Inside App both audio and video return highlighted text.
  ##2. On large content of text data it's become feasible with autoscrolling from bottom text. 
  ##3. Can Manage Forward and backword with transcript text(In Progress).
  ##4. Play and Pause with highlighted transcript.

#Code Examples

  There are some essential methods and properties are caaled Delegate used for BMPlayer as BMPlayerDelegate and BMPlayerControlViewDelegate below methods mentions
  
      func controlView(controlView: BMPlayerControlView, didChooseDefinition index: Int){
        print(index)
    }
    
    func controlView(controlView: BMPlayerControlView, didPressButton button: UIButton){
        print(controlView)
    }
   
    func controlView(controlView: BMPlayerControlView, slider: UISlider, onSliderEvent event: UIControl.Event){
        print(slider)
    }
     
    func controlView(controlView: BMPlayerControlView, didChangeVideoPlaybackRate rate: Float){
        print(rate)
    }

    
    
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        print(state)
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        print(totalDuration)        
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        let selectText = player.resource.subtitle?.search(for: currentTime)?.text
        if  let _ = self.trancriptContent.localizedStandardRange(of: selectText ?? ""){
            if selectText != ""{
                guard let textFound = selectText else {
                    return
                }
                self.loadTextInTableViewWithHighlighted(text: textFound)
            }
        }
     }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        print(playing)
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        print(isFullscreen)
    }
    
    
    ********* For Making Highlighted Text appeared from audio and video, containing into extension ********
    
    extension ViewController{
    func loadTextInTableViewWithHighlighted(text:String){
        if text != ""{
            if let string = self.textContent.text, let range = string.localizedStandardRange(of: text) {
                if text != ""{
                    let viewRange = NSRange(range, in: string)
                    self.textContent.selectedRange = viewRange
                    self.currentTextLocation = self.textContent.selectedRange.location
                    let textSring = NSMutableAttributedString(string: trancriptContent)
                    if self.currentTextLocation >= self.previousTextLocation{
                        if UIDevice.current.userInterfaceIdiom == .pad{
                            textSring.setColorForText(text, with: .black)
                            textSring.addAttribute(.backgroundColor, value: UIColor(named: "#FFCFCF") ?? .orange, range: NSRange(location: self.currentTextLocation, length: text.count))
                            self.textContent.text = ""
                            self.textContent.attributedText = nil
                            self.textContent.attributedText = textSring
                            self.textContent.font = UIFont(name: "Roboto", size: 22.0)
                            self.textContent.textAlignment = .justified
                            self.previousTextLocation = self.currentTextLocation
                            self.textContent.scrollRangeToVisible(NSRange(location:viewRange.location, length:viewRange.length))
                        } else {
                            textSring.setColorForText(text, with: .black)
                            textSring.addAttribute(.backgroundColor, value: UIColor(named: "#FFCFCF") ?? .orange, range: NSRange(location: self.currentTextLocation, length: text.count))
                            self.textContent.text = ""
                            self.textContent.attributedText = nil
                            self.textContent.attributedText = textSring
                            self.textContent.font = UIFont(name: "Roboto", size: 16.0)
                            self.textContent.textAlignment = .justified
                            self.previousTextLocation = self.currentTextLocation
                            self.textContent.scrollRangeToVisible(viewRange)
                        }
                      //  self.audioLocationDelegate?.getcurrentAndPreviousLocation(currentTextLocation: self.currentTextLocation, previousTextLocation: self.previousTextLocation)
                    }else{
                        self.textContent.textAlignment = .justified
                        var totlaTextLength:Int = 0
                        var curentTextLoc: Int = 0
                        let content : String = self.trancriptContent
                        let range = content.ranges(of: text)
                        for i in 0 ..< range.count{
                            if range[i].lowerBound.utf16Offset(in: content) > self.previousTextLocation{
                                totlaTextLength = range[i].upperBound.utf16Offset(in: content)-range[i].lowerBound.utf16Offset(in: content)
                                curentTextLoc = range[i].lowerBound.utf16Offset(in: content)
                                var seeRange = NSRange(location: curentTextLoc, length: totlaTextLength)
                                let getTextAtRange = textSring.attributedSubstring(from: seeRange)
                                let selectTetx = getTextAtRange.string
                                seeRange = (textSring.string as NSString).range(of: selectTetx, options: [], range: seeRange)
                                if (seeRange.location != NSNotFound) {
                                    textSring.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: seeRange.location, length: seeRange.length))
                                    textSring.addAttribute(.backgroundColor, value: UIColor(named: "#FFCFCF") ?? .blue, range: NSRange(location: seeRange.location, length: seeRange.length))
                                    seeRange = NSRange(location: seeRange.location + seeRange.length, length: textSring.string.count - (seeRange.location + seeRange.length))
                                    self.textContent.attributedText = textSring
                                    self.textContent.font = (UIDevice.current.userInterfaceIdiom == .pad) ? UIFont(name: "Roboto", size: 22.0) : UIFont(name: "Roboto", size: 16.0)
                                    self.textContent.textAlignment = .justified
                                    self.currentTextLocation = curentTextLoc
                               //     self.audioLocationDelegate?.getcurrentAndPreviousLocation(currentTextLocation: self.currentTextLocation, previousTextLocation: self.previousTextLocation)
                                    break
                                }
                            }
                        }
                    }
                } else {
                }
            } else {
            }
        }
    }
}

      ******** To provide color into selected text  *********
      extension NSMutableAttributedString{
    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            var boldFont : UIFont = UIFont()
            boldFont = UIFont(name: "Helvetica Neue", size: 15)!
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            addAttribute(NSAttributedString.Key.font, value: boldFont, range: range)
        }
    }
}

#Installation

#API reference

#Tests

#How to Use?

#Contribute

  ## There is most contribution of BMPlayer that help out much to achive transcript.

#Credits
  ## BMPlayer

#License

