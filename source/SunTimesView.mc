using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Application.Properties as Props;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Attention;
using Toybox.System as Sys;

const cUseIn = true;
const cBacklightControl = false;
const cBacklightOffset = 0;

class SunTimesView extends Ui.DataField {
	hidden var mLaidOut = false;

    hidden var mNoMeridiem = false;
    hidden var mWidth;
    hidden var mUseIn = true;
    hidden var mValue = "00:00";
    hidden var mMeridiem = "";
    hidden var mLabel = "Sun Time";
    hidden var NoGPSData = "No GPS signal";
    hidden var Sunrise = "Sunrise";
    hidden var Sunset = "Sunset";
    hidden var mLabelAlt = "Sun Time";
    hidden var NoGPSDataAlt = "No GPS";
    hidden var SunriseAlt = "Sunrise";
    hidden var SunsetAlt = "Sunset";
    hidden var In = "in";
    
    hidden var mBacklightControl = false;
    hidden var mBacklightOffset = 0;
    hidden var mWasBacklight = true;
    

    function initialize() {
    	var tmpProp;
        DataField.initialize();
        
		if ( App has :Properties ) {
	        tmpProp = Props.getValue("inAt");
	    } else {
	        tmpProp = App.getApp().getProperty("inAt");
	    }
       	mUseIn = (tmpProp != null && tmpProp instanceof Number) ? (tmpProp == 0) : cUseIn;

		if ( App has :Properties ) {
	        tmpProp = Props.getValue("blControl");
	    } else {
	        tmpProp = App.getApp().getProperty("blControl");
	    }
       	mBacklightControl = (tmpProp != null && tmpProp instanceof Number) ? (tmpProp != 0) : cBacklightControl;

		if ( App has :Properties ) {
	        tmpProp = Props.getValue("blOffset");
	    } else {
	        tmpProp = App.getApp().getProperty("blOffset");
	    }
       	mBacklightOffset = (tmpProp != null && tmpProp instanceof Number) ? tmpProp.toNumber() : cBacklightOffset;

    	var temp;
        temp = Ui.loadResource( Rez.Strings.NoData );
        if (temp != null ) {NoGPSData = temp;}
        temp = Ui.loadResource( Rez.Strings.Sunrise );
        if (temp != null ) {Sunrise = temp;}
        temp = Ui.loadResource( Rez.Strings.Sunset );
        if (temp != null ) {Sunset = temp;}
        temp = Ui.loadResource( Rez.Strings.NoDataAlt );
        if (temp != null ) {NoGPSDataAlt = temp;}
        temp = Ui.loadResource( Rez.Strings.SunriseAlt );
        if (temp != null ) {SunriseAlt = temp;}
        temp = Ui.loadResource( Rez.Strings.SunsetAlt );
        if (temp != null ) {SunsetAlt = temp;}
        temp = Ui.loadResource( Rez.Strings.In );
        if (temp != null ) {In = temp;}

    }
// ----------------------------------------------

	(:marq)
    function getYAdjust(dc, obscurityFlags) {
    	var adj = -1;
    	var height = dc.getHeight();
		if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
				adj = height > 90 ? 0 : 3;
		} else 
		if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
				adj = height > 90 ? 15 : 4;
		}
	    return adj;
    }

	(:venu)
    function getYAdjust(dc, obscurityFlags) {
    	var adj = -1;
		if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT) || obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			adj = (dc.getHeight() > 190) ? 22 : 4;
		}
	    return adj;
    }

	(:fenix6)
    function getYAdjust(dc, obscurityFlags) {
    	return null;
    }
    
	(:fenix6s)
    function getYAdjust(dc, obscurityFlags) {
    	return null;
    }
    
	(:fenix6xpro)
    function getYAdjust(dc, obscurityFlags) {
    	return null;
    }
    
	(:fr2945)
    function getYAdjust(dc, obscurityFlags) {
    	var adj = -1;
    	var height = dc.getHeight();
		if (obscurityFlags == (OBSCURE_LEFT | OBSCURE_RIGHT)) {
				if (height > 80) {adj = 1;}
		} else 
		if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
				if (height < 90) {adj = 2;}
		} else 
		if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
//				adj = height > 90 ? 15 : 4;
				if (height < 90) {adj = 4;}
		}
	    return adj;
    }

	(:vivo3)
    function getYAdjust(dc, obscurityFlags) {
    	var adj = -1;
    	var height = dc.getHeight();
		if (obscurityFlags == (OBSCURE_LEFT | OBSCURE_RIGHT) && (height > 100)) {
			adj = 8;
		} else 
		if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height > 105) {adj = 0;}
			else if (height > 100) {adj = 10;}
			else {adj = 3;}

		} else 
		if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height > 115) {adj = 8;}
			else if (height > 105) {adj = 15;}
			else if (height > 100) {adj = 10;}
			else {adj = 4;}
		}
	    return adj;
    }

	(:vivo4)
    function getYAdjust(dc, obscurityFlags) {
    	var adj = -1;
    	var height = dc.getHeight();
		if (obscurityFlags == (OBSCURE_LEFT | OBSCURE_RIGHT) && (height > 100)) {
			adj = 8;
		} else 
		if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height > 105) {adj = 0;}
			else if (height > 100) {adj = 10;}
			else {adj = 3;}

		} else 
		if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height > 115) {adj = 8;}
			else if (height > 105) {adj = 15;}
			else if (height > 100) {adj = 10;}
			else {adj = 4;}
		}
	    return adj;
    }

	(:vivo4s)
    function getYAdjust(dc, obscurityFlags) {
    	var adj = -1;
    	var height = dc.getHeight();
		if (obscurityFlags == (OBSCURE_LEFT | OBSCURE_RIGHT) && (height > 100)) {
			adj = 8;
		} else 
		if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height > 105) {adj = 0;}
			else if (height > 100) {adj = 10;}
			else {adj = 3;}

		} else 
		if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height > 115) {adj = 8;}
			else if (height > 105) {adj = 15;}
			else if (height > 100) {adj = 10;}
			else {adj = 4;}
		}
	    return adj;
    }

	(:avenger)
    function getYAdjust(dc, obscurityFlags) {
    	var adj = -1;
		if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
				adj = 4;
		} else 
		if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
				adj = 3;
		}
	    return adj;
    }

	(:marvel)
    function getYAdjust(dc, obscurityFlags) {
    	var adj = -1;
		if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
				adj = (dc.getHeight() > 70) ? 6 : 2;
		} else 
		if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
				adj = 1;
		}
	    return adj;
    }

	(:fr735xt)
    function getYAdjust(dc, obscurityFlags) {
    	var adj = -1;
		if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
				adj = 3;
		} else 
		if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
				adj = 4;
		}
	    return adj;
    }

	(:approachs60)
    function getYAdjust(dc, obscurityFlags) {
    	var adj = -1;
		if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
				if (dc.getHeight() < 90) {adj = 4;}
		} else
		if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
				if (dc.getHeight() < 90) {adj = 9;}
		} 
	    return adj;
    }

	(:approachs62)
    function getYAdjust(dc, obscurityFlags) {
    	var adj = -1;
		var ht = dc.getHeight();
		if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			adj = (ht < 90) ? 3 : 0;
		} else
		if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			adj = (ht < 90) ? 9 : 16;
		} else
		if (obscurityFlags == (OBSCURE_LEFT | OBSCURE_RIGHT)) {
			adj = (ht < 90) ? 3 : 12;
		} 
	    return adj;
    }

	(:other_round)
    function getYAdjust(dc, obscurityFlags) {
    	var adj = -1;
		if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			adj = 0;
		} else 
		if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			adj = 4;
		}
	    return adj;
    }

// ---
	(:vivoactive_hr)
    function getYAdjust(dc, obscurityFlags) {
    	var height = dc.getHeight();
		var ret = 15;
		if (height < 80) {ret = 4;}
		else if (height < 105) {ret = 3;}
	    return ret;
    }

	(:e520_820)
    function getYAdjust(dc, obscurityFlags) {
	    return 2;
    }

	(:e530_830)
    function getYAdjust(dc, obscurityFlags) {
	    return -2;
    }

	(:e130)
    function getYAdjust(dc, obscurityFlags) {
	    return 10;
    }

	(:other_rectanglesY)
    function getYAdjust(dc, obscurityFlags) {
	    return -1;
    }

// ----------------------------------------------

	(:fr735xt)
    function doFont(valueView, ySpace, myF) {
   		if (ySpace > 69) {
   			myF += 1;
			valueView.setFont(myF);
		}
		return myF;
	}

	(:approachs60)
    function doFont(valueView, ySpace, myF) {
		valueView.setFont(myF);
		return myF;
    }

	(:approachs62)
    function doFont(valueView, ySpace, myF) {
   		if (ySpace > 58) {
			myF += 1;
		}
		valueView.setFont(myF);
		return myF;
    }

	(:marq)
    function doFont(valueView, ySpace, myF) {
   		if (ySpace > 77) {
			myF += 1;
			valueView.setFont(myF);
		}
		return myF;
    }

	(:venu)
    function doFont(valueView, ySpace, myF) {
   		if (ySpace > 90) {
			myF += 1;
			valueView.setFont(myF);
		}
		return myF;
    }

	(:fr2945)
    function doFont(valueView, ySpace, myF) {
		valueView.setFont(myF);
		return myF;
    }

	(:vivo3)
    function doFont(valueView, ySpace, myF) {
   		if (ySpace > 70) {
			myF += 1;
			valueView.setFont(myF);
		}
		return myF;
    }

	(:vivo4)
    function doFont(valueView, ySpace, myF) {
   		if (ySpace > 70) {
			myF += 1;
			valueView.setFont(myF);
		}
		return myF;
    }

	(:vivo4s)
    function doFont(valueView, ySpace, myF) {
   		if (ySpace > 70) {
			myF += 1;
			valueView.setFont(myF);
		}
		return myF;
    }

	(:other_round)
    function doFont(valueView, ySpace, myF) {
   		if (ySpace > 77) {
			myF += 1;
			valueView.setFont(myF);
		}
		return myF;
    }

	(:avenger)
    function doFont(valueView, ySpace, myF) {
   		if (ySpace > 65) {
   			myF += 1;
		}
		valueView.setFont(myF);
		return myF;
    }

	(:marvel)
    function doFont(valueView, ySpace, myF) {
   		if (ySpace > 77) {
			myF += 1;
			valueView.setFont(myF);
		}
		return myF;
    }


// ----------------------------------------------

	(:avenger)
    function getXMXadjust(height) {
	    return (height < 90) ? 2 : 6;
    }

	(:marvel)
    function getXMXadjust(height) {
	    return (height < 80) ? 1 : 5;
    }

	(:marq)
    function getXMXadjust(height) {
	    return (height > 90) ? 7 : 2;
    }

	(:venu)
    function getXMXadjust(height) {
	    var ret = (height > 130) ? 13 : 3;
		return ret; 
    }

	(:fr2945)
    function getXMXadjust(height) {
	    return 3;
    }

	(:vivo3)
    function getXMXadjust(height) {
	    var ret = 2;
	    if (height > 100) {ret = 15;}
	    return ret;
    }

	(:vivo4)
    function getXMXadjust(height) {
	    var ret = 4;
	    if (height > 100) {ret = 6;}
	    return ret;
    }

	(:vivo4s)
    function getXMXadjust(height) {
	    var ret = 2;
	    if (height > 105) {ret = 5;}
	    return ret;
    }

	(:fr735xt)
    function getXMXadjust(height) {
	    return 10;
    }

	(:approachs60)
    function getXMXadjust(height) {
	    return 2;
    }

	(:approachs62)
    function getXMXadjust(height) {
	    var ret = 2;
	    if (height > 90) {ret = 6;}
	    return ret;
    }

	(:other_round)
    function getXMXadjust(height) {
	    return (height > 90) ? 3 : -1;
    }

// -----
	(:e1030)
    function getXMXadjust(meridiemView, width, height) {
		var adj = 9;
		if (height < 95) {adj = (width < 150) ? 2 : 5;}
		if (width > 150) {
			meridiemView.setFont(Gfx.FONT_TINY);
		}
	    return adj;
    }

	(:e520_820)
    function getXMXadjust(meridiemView, width, height) {
		var adj = 8;
		if (height < 54) {adj = (width < 150) ? -4 : 4;}
		else if (height < 67) {adj = 4;}
		if (width > 150) {
			meridiemView.setFont(Gfx.FONT_TINY);
			adj -= 4;			
		}
	    return adj;
    }

	(:e530_830)
    function getXMXadjust(meridiemView, width, height) {
		var adj = 11;
		if (height < 64) {adj = 1;}
		else if (height < 80) {adj = 3;}
		else if (height < 105) {adj = 4;}
		if (width > 150) {
			meridiemView.setFont(Gfx.FONT_TINY);
			adj -= 3;
		}
	    return adj;
    }

	(:gpsmap)
    function getXMXadjust(meridiemView, width, height) {
		var ret = -2;
		if (height > 100) {
			meridiemView.setFont(Gfx.FONT_TINY);
			ret = 1;
		}
	    else if (height > 52) { ret = -2;}
		return ret;
    }

	(:e130)
    function getXMXadjust(meridiemView, width, height) {
    	var ret = -16;
		if (width < 150) {
			mNoMeridiem = true;
		} else
		if (height > 150) {
			ret = -11;
		}

	    return ret;
    }

	(:vivoactive_hr)
    function getXMXadjust(meridiemView, width, height) {
	    return 4;
    }

	(:other_rectanglesXM)
    function getXMXadjust(meridiemView, width, height) {
    	var x = 5;
		if (height < 80) {
			x = 2;
		}
		if (width > 150) {
			meridiemView.setFont(Gfx.FONT_TINY);
			x += 4;
		}
	    return x;
    }
// ----------------------------------------------

	(:avenger)
    function getXMYadjust(height) {
	    return (height < 90) ? -8 : -19;
    }

	(:marvel)
    function getXMYadjust(height) {
	    return (height < 80) ? -7 : -16;
    }

	(:marq)
    function getXMYadjust(height) {
    	return (height > 90) ? -18 : -11;
    }

	(:venu)
    function getXMYadjust(height) {
    var ret;
        if (height <= 130) {
        	ret = -10;
        } else {
	        var obscurityFlags = DataField.getObscurityFlags();
	        ret = (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) ? -73 : -15;
		}
		return ret; 
    }

	(:fr2945)
    function getXMYadjust(height) {
	    return (height > 90) ? -18 : -7;
    }

	(:vivo3)
    function getXMYadjust(height) {
	    var ret = -8;
	    if (height > 100) {ret = -15;}
    	return ret;
    }

	(:vivo4)
    function getXMYadjust(height) {
	    var ret = -8;
	    if (height > 100) {ret = -18;}
    	return ret;
    }

	(:vivo4s)
    function getXMYadjust(height) {
	    var ret = -6;
	    if (height > 105) {ret = -16;}
    	return ret;
    }

	(:fr735xt)
    function getXMYadjust(height) {
	    return (height > 55) ? -7 : -4;
    }

	(:approachs60)
    function getXMYadjust(height) {
	    return -8;
    }

	(:approachs62)
    function getXMYadjust(height) {
    	var ret = -8;
        if (height > 90 || (DataField.getObscurityFlags() == (OBSCURE_LEFT | OBSCURE_RIGHT) && height > 82)) {
       		ret = -19;
        }
	    return ret;
    }

	(:other_round)
    function getXMYadjust(height) {
	    return 4;
    }

// ---

	(:vivoactive_hr)
    function getXMYadjust(width, height) {
	    return 2;
    }

	(:e520_820)
    function getXMYadjust(width, height) {
		var y = 9;
		if (height < 54) { y = (width < 100) ? 4 : 5;}
		else if (height < 68) {y = 8;}
		if (width > 150) {
			y += 3;
		}
	    return y;
    }

	(:e530_830)
    function getXMYadjust(width, height) {
		var y = 14;
		if (height < 79) {y = 8;}
		else if (height < 80) {y = 10;}
		else if (height < 105) {y = 8;}
		if (width > 150) {y += 3;}
	    return y;
    }

	(:gpsmap)
    function getXMYadjust(width, height) {
	    var ret = 15;
	    if (height < 55) {ret = 9;}
	    else if (height < 100) {ret = 8;}
		return ret;
    }

	(:e1030)
    function getXMYadjust(width, height) {
		var y = 11;
		if (height < 95 && width > 150) {y = 8;}
		if (width > 150) {y += 5;}
		return y;
    }

	(:e130)
    function getXMYadjust(width, height) {
		var y = 13;
		if (height < 80) {y = 8;}
		else if (height < 110) {y = 12;}
		return y;
    }

	(:other_rectanglesXM)
    function getXMYadjust(width, height) {
		var y = (height < 80) ? 9 : 13;
		if (width > 150) {y += 3;}
		return y;
    }

// ----------------------------------------------

	(:rectangle_layout)
	function doLayout(dc, yAdjust) {
       	var width = dc.getWidth();

       	var valueView = View.findDrawableById("value");
       	var meridiemView = View.findDrawableById("meridiem");
        var height = dc.getHeight();
        var labelHt = dc.getFontHeight(Gfx.FONT_TINY);
		var ySpace = height - labelHt + yAdjust;
		var md = dc.getTextDimensions(" XM ", Gfx.FONT_XTINY);
		var mxadj = getXMXadjust(meridiemView, width, height);
		var mx = (mUseIn || mNoMeridiem || Sys.getDeviceSettings().is24Hour) ? 0 : md[0];
		var d = [0, 0];
		var myF = 0;
  		var f = 8;
		while (f >= 0) {
       		d = dc.getTextDimensions("00:00 ", f);
    		if ((d[0]+mx) <= width && d[1] <= ySpace) {
    			myF = f;
		   		break;
       		}
       		f = f-1;
       	}

		d = dc.getTextDimensions("00:00 ", myF);
   		var valueAsc = Graphics.getFontAscent(myF);
        valueView.setFont(myF);
		valueView.locY = labelHt + ((ySpace - valueAsc - 2) / 2) - yAdjust;
       	meridiemView.locX = (width + d[0]) / 2 - mxadj;
       	meridiemView.locY = valueView.locY + d[1] - valueAsc - getXMYadjust(width, height);
       	return width - 5;
	}

	(:round_layout)
	function doLayout(dc, yAdjust) {
	
       	var width = dc.getWidth();
		var meridiemView = null;
	    if (!mNoMeridiem) {
	       	meridiemView = View.findDrawableById("meridiem");
		}
		if (yAdjust >= 0) {
	        var height = dc.getHeight();
    	    var labelHt = dc.getFontHeight(Gfx.FONT_TINY);
	       	var labelView = View.findDrawableById("label");
    	   	var valueView = View.findDrawableById("value");
			var ySpace = height - labelView.locY - labelHt;
			var myF = doFont(valueView, ySpace, Gfx.FONT_NUMBER_MEDIUM);
			var d = dc.getTextDimensions("00:00 ", myF);
			valueView.locY = labelView.locY + labelHt  + (ySpace - d[1]) / 2 - yAdjust;
		    if (meridiemView != null) {
    		   	meridiemView.locX = (width + d[0]) / 2 - getXMXadjust(height);
	    	   	meridiemView.locY = valueView.locY - getXMYadjust(height);
			}
	    }
	    if (!mNoMeridiem) {
			var md = dc.getTextDimensions("XM ", Gfx.FONT_XTINY);
    	   	if ((meridiemView.locX + md[0]) > width) {
	       		mNoMeridiem = true;
	       	}
		}

       	return width - 5;
	}

	(:fenix6s)
	function doLayout(dc, yAdjust) {
        var obscurityFlags = DataField.getObscurityFlags();
       	var width = dc.getWidth();
        var height = dc.getHeight();
   	   	var valueView = View.findDrawableById("value");
       	var meridiemView = View.findDrawableById("meridiem");
       	var myF = null;

        // Top left quadrant so we'll use the top left layout - 3
        // Top right quadrant so we'll use the top right layout - 6

        // Top sector so we'll use the generic, centered layout shifted - 7
        if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height < 60) {
				myF = Gfx.FONT_NUMBER_MILD; valueView.locY -= 11;
				meridiemView.locX -= 34; meridiemView.locY = valueView.locY + 9;
			} else if (height < 83) {
				myF = Gfx.FONT_NUMBER_MEDIUM; valueView.locY -= 9;
				meridiemView.locX -= 25; meridiemView.locY -= 49;
			} else if (height < 90) {
				valueView.locY -= 15;
				meridiemView.locY -= 15;
			}

        // Middle sector so we'll use the generic, centered layout shrunk - 5
        } else if (obscurityFlags == (OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height < 60) {
				myF = Gfx.FONT_NUMBER_MILD; valueView.locY += 4;
				meridiemView.locX -= 34; meridiemView.locY -= 4;
			} else if (height < 70) {
				myF = Gfx.FONT_NUMBER_MEDIUM;
				valueView.locY -= 1;
				meridiemView.locX -= 25; meridiemView.locY -= 8;
			} else if (height < 74) {
				myF = Gfx.FONT_NUMBER_MEDIUM;
				valueView.locY += 2;
				meridiemView.locX -= 25; meridiemView.locY -= 3;
			}

        // Middle sector left so we'll use the generic, centered layout shrunk - 1
        } else if (obscurityFlags == (OBSCURE_LEFT)) {
            mNoMeridiem = true;
			if (height < 60) {valueView.locY -= 4;}

        // Middle sector right so we'll use the generic, centered layout shrunk - 4
        } else if (obscurityFlags == (OBSCURE_RIGHT)) {
            mNoMeridiem = true;
			if (height < 60) {valueView.locY -= 4;}

        // Bottom sector so we'll use the generic, centered layout upside down - 13
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height < 70) {
				myF = Gfx.FONT_NUMBER_MILD; valueView.locY -= 5;
				meridiemView.locX -= 34; meridiemView.locY = valueView.locY + 9;
			} else if (height < 90) {
				myF = Gfx.FONT_NUMBER_MEDIUM;
				if (height < 83) {
					valueView.locY -= 3;
					meridiemView.locX -= 25; meridiemView.locY -= 8;
				} else {
					valueView.locY += 3;
					meridiemView.locX -= 25; meridiemView.locY -= 2;
				}
			}
		}

		if (myF != null) {
			valueView.setFont(myF);
		}

       	return width - 5;
	}

	(:fenix6)
	function doLayout(dc, yAdjust) {
        var obscurityFlags = DataField.getObscurityFlags();
       	var width = dc.getWidth();
        var height = dc.getHeight();
   	   	var valueView = View.findDrawableById("value");
       	var meridiemView = View.findDrawableById("meridiem");
       	var myF = null;

        // Top left quadrant so we'll use the top left layout - 3
        // Top right quadrant so we'll use the top right layout - 6

        // Top sector so we'll use the generic, centered layout shifted - 7
        if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height < 70) {
				myF = Gfx.FONT_NUMBER_MILD; valueView.locY -= 17;
				meridiemView.locX -= 37; meridiemView.locY = valueView.locY + 10;
			} else if (height < 88) {
				myF = Gfx.FONT_NUMBER_MEDIUM; valueView.locY -= 15;
				meridiemView.locX -= 26; meridiemView.locY -= 57;
			} else if (height < 100) {
				valueView.locY -= 18;
				meridiemView.locY -= 18;
			}

        // Middle sector so we'll use the generic, centered layout shrunk - 5
        } else if (obscurityFlags == (OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height < 60) {
				myF = Gfx.FONT_NUMBER_MILD;
				meridiemView.locX -= 42; meridiemView.locY -= 10;
			} else if (height < 70) {
				myF = Gfx.FONT_NUMBER_MEDIUM;
				valueView.locY -= 2;
				meridiemView.locX -= 27; meridiemView.locY -= 9;
			} else if (height < 85) {
				valueView.locY -= 2;
				meridiemView.locY -= 3;
			}

        // Middle sector left so we'll use the generic, centered layout shrunk - 1
        } else if (obscurityFlags == (OBSCURE_LEFT)) {
            mNoMeridiem = true;
			if (height < 70) {valueView.locY -= 4;}
        // Middle sector right so we'll use the generic, centered layout shrunk - 4
        } else if (obscurityFlags == (OBSCURE_RIGHT)) {
            mNoMeridiem = true;
			if (height < 70) {valueView.locY -= 4;}

        // Bottom sector so we'll use the generic, centered layout upside down - 13
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height < 70) {
				myF = Gfx.FONT_NUMBER_MILD; valueView.locY -= 3;
				meridiemView.locX -= 37; meridiemView.locY = valueView.locY + 10;
			} else if (height < 100) {
				myF = Gfx.FONT_NUMBER_MEDIUM;
				if (height < 88) {
					valueView.locY -= 2;
					meridiemView.locX -= 26; meridiemView.locY -= 9;
				} else {
					valueView.locY += 3;
					meridiemView.locX -= 26; meridiemView.locY -= 4;
				}
			}
		}

		if (myF != null) {
			valueView.setFont(myF);
		}

       	return width - 5;
	}

	(:fenix6xpro)
	function doLayout(dc, yAdjust) {
        var obscurityFlags = DataField.getObscurityFlags();
       	var width = dc.getWidth();
        var height = dc.getHeight();
   	   	var valueView = View.findDrawableById("value");
       	var meridiemView = View.findDrawableById("meridiem");
       	var myF = null;

        // Top left quadrant so we'll use the top left layout - 3
        // Top right quadrant so we'll use the top right layout - 6

        // Top sector so we'll use the generic, centered layout shifted - 7
        if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height < 50) {
				myF = Gfx.FONT_SMALL; 
				valueView.locY -= 18;
				meridiemView.locX -= 65; meridiemView.locY = valueView.locY + 4;
			} else if (height < 60) {
				myF = Gfx.FONT_SMALL; valueView.locY -= 4;
				meridiemView.locX -= 65; meridiemView.locY = valueView.locY + 12;
			} else if (height < 70) {
				myF = Gfx.FONT_NUMBER_MILD; valueView.locY -= 18;
				meridiemView.locX -= 43; meridiemView.locY = valueView.locY + 12;
			} else if (height < 95) {
				myF = Gfx.FONT_NUMBER_MEDIUM; valueView.locY -= 15;
				meridiemView.locX -= 31; meridiemView.locY -= 61;
			} else if (height < 100) {
				valueView.locY -= 21;
				meridiemView.locY -= 21;
			}

        // Middle sector so we'll use the generic, centered layout shrunk - 5
        } else if (obscurityFlags == (OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height < 60) {
				myF = Gfx.FONT_NUMBER_MILD;
				meridiemView.locX -= 42; meridiemView.locY -= 10;
			} else if (height < 70) {
				myF = Gfx.FONT_NUMBER_MEDIUM;
				valueView.locY -= 2;
				meridiemView.locX -= 30; meridiemView.locY -= 6;
			} else if (height < 90) {
				valueView.locY -= 2;
				meridiemView.locY -= 1;
			}

        // Middle sector left so we'll use the generic, centered layout shrunk - 1
        } else if (obscurityFlags == (OBSCURE_LEFT)) {
			if (height < 60) {
				myF = Gfx.FONT_LARGE;
				meridiemView.locY = valueView.locY + 5;
			} else {
				if (height < 70) {valueView.locY -= 4;}
	            mNoMeridiem = true;
			}
        // Middle sector right so we'll use the generic, centered layout shrunk - 4
        } else if (obscurityFlags == (OBSCURE_RIGHT)) {
            mNoMeridiem = true;
			if (height < 60) {
				myF = Gfx.FONT_LARGE;
			} else if (height < 70) {
				valueView.locY -= 4;
			}

        // Bottom sector so we'll use the generic, centered layout upside down - 13
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
			if (height < 60) {
				myF = Gfx.FONT_SMALL; valueView.locY -= 2;
				meridiemView.locX -= 65; meridiemView.locY = valueView.locY + 3;
			} else if (height < 70) {
				myF = Gfx.FONT_NUMBER_MILD; valueView.locY -= 7;
				meridiemView.locX -= 43; meridiemView.locY = valueView.locY + 11;
			} else if (height < 100) {
				myF = Gfx.FONT_NUMBER_MEDIUM;
				if (height < 95) {
					valueView.locY -= 6;
					meridiemView.locX -= 31; meridiemView.locY -= 12;
				} else {
					valueView.locY -= 2;
					meridiemView.locX -= 31; meridiemView.locY -= 8;
				}
			}
		}

		if (myF != null) {
			valueView.setFont(myF);
		}

        // Bottom left quadrant so we'll use the bottom left layout - 9
        // Bottom right quadrant so we'll use the bottom right layout - 12
        // Use the generic, centered layout

       	return width - 5;
	}

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc) {
    	mLaidOut = false;
    	return true;
    }

    function myLayout(dc) {
		mNoMeridiem = false;

        var obscurityFlags = DataField.getObscurityFlags();
        var adj = -1;

        // Top left quadrant so we'll use the top left layout - 3
        if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.TopLeftLayout(dc));
            mNoMeridiem = true;

        // Top right quadrant so we'll use the top right layout - 6
        } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.TopRightLayout(dc));
            mNoMeridiem = true;

        // Top sector so we'll use the generic, centered layout shifted - 7
        } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.TopCentreLayout(dc));
            adj = getYAdjust(dc, obscurityFlags);

        // Middle sector so we'll use the generic, centered layout shrunk - 5
        } else if (obscurityFlags == (OBSCURE_LEFT | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.MiddleCentreLayout(dc));
            adj = getYAdjust(dc, obscurityFlags);

        // Middle sector left so we'll use the generic, centered layout shrunk - 1
        } else if (obscurityFlags == (OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.MiddleLeftLayout(dc));

        // Middle sector right so we'll use the generic, centered layout shrunk - 4
        } else if (obscurityFlags == (OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.MiddleRightLayout(dc));

        // Bottom sector so we'll use the generic, centered layout upside down - 13
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.BottomCentreLayout(dc));
            adj = getYAdjust(dc, obscurityFlags);

        // Bottom left quadrant so we'll use the bottom left layout - 9
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.BottomLeftLayout(dc));
            mNoMeridiem = true;

        // Bottom right quadrant so we'll use the bottom right layout - 12
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.BottomRightLayout(dc));
            mNoMeridiem = true;

        // Use the generic, centered layout
        } else {
            View.setLayout(Rez.Layouts.MainLayout(dc));
            adj = getYAdjust(dc, obscurityFlags);
        }

		mWidth = doLayout(dc, adj);
        return true;
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
	    var Accuracy = 2;

		mLabel = NoGPSData;
		mLabelAlt = NoGPSDataAlt;
		mValue = "00:00";
		mMeridiem = "";
        // See Activity.Info in the documentation for available information.
	    if (info has :currentLocationAccuracy && info.currentLocationAccuracy != null) {
	    	Accuracy = info.currentLocationAccuracy;
	    }
		if (info has :currentLocation) {
            if (info.currentLocation != null && Accuracy > 1) {
	    		var sc = new SunCalc();
	    	    var position = info.currentLocation;
    			var loc = info.currentLocation.toRadians();
	    		var time_now = Time.now();
//time_now = time_now.add(new Time.Duration(93740));
	    		var time_tomorrow = time_now.add(new Time.Duration(Gregorian.SECONDS_PER_DAY));
	    		var sunrise_time = sc.calculate(time_now, loc[0], loc[1], SUNRISE);
		    	if (sunrise_time == null) {
		    		return;
		    	}
		    	var sunrise_today = sunrise_time;
		    	if (sunrise_time.lessThan(time_now)) {
		    		sunrise_time = sc.calculate(time_tomorrow, loc[0], loc[1], SUNRISE);
			    	if (sunrise_time == null) {
			    		return;
			    	}
	    		}
	    		var sunset_time = sc.calculate(time_now, loc[0], loc[1], SUNSET);
		    	if (sunset_time == null) {
		    		return;
		    	}
		    	var sunset_today = sunset_time;
		    	if (sunset_time.lessThan(time_now)) {
		    		sunset_time = sc.calculate(time_tomorrow, loc[0], loc[1], SUNSET);
			    	if (sunset_time == null) {
			    		return;
			    	}
	    		}
	    		var till_sunrise = sunrise_time.subtract(time_now);
	    		var till_sunset = sunset_time.subtract(time_now);
	    		var mins_till_sunrise = till_sunrise.value() / 60;
	    		var mins_till_sunset = till_sunset.value() / 60;
	    		var time_to_go;
	    		var next_time;
	    		if (mins_till_sunset == 0) {
	    			time_to_go = till_sunrise;
	    			next_time = sunrise_time;
	    			mLabel = Sunrise;
	    			mLabelAlt = SunriseAlt;
	    		} else if (mins_till_sunrise == 0) {
	    			time_to_go = till_sunset;
	    			next_time = sunset_time;
	    			mLabel = Sunset;
	    			mLabelAlt = SunsetAlt;
	    		} else if (sunset_time.lessThan(sunrise_time)) {
	    			time_to_go = till_sunset;
	    			next_time = sunset_time;
	    			mLabel = Sunset;
	    			mLabelAlt = SunsetAlt;
	    		} else {
	    			time_to_go = till_sunrise;
	    			next_time = sunrise_time;
	    			mLabel = Sunrise;
	    			mLabelAlt = SunriseAlt;
	    		}

	    		if (mUseIn) {
	    			mLabel = mLabel + " " + In;
	    			mLabelAlt = mLabelAlt + " " + In;
                	mValue = sc.durationToString(time_to_go);
					mMeridiem = "";
	    		} else {
	                var temp = sc.momentToString(next_time);
	                mValue = temp[0];
	                mMeridiem = temp[1];
                }

	    		if (mBacklightControl && Attention has :backlight ) {
	    			var offsetOn = new Time.Duration((mBacklightOffset-1)*Gregorian.SECONDS_PER_MINUTE);
		    		var lightOn = sunset_today.add(offsetOn);
// Can't subtract a duration from a moment on some systems, so add a -ve duration
	    			var offsetOff = new Time.Duration(-(mBacklightOffset+1)*Gregorian.SECONDS_PER_MINUTE);
		    		var lightOff = sunrise_today.add(offsetOff);
					var backLight = (time_now.greaterThan(lightOff) && time_now.lessThan(lightOn)) ? false : true;
// turn it on or off when conditions change - always turn it on at night
		    	    if (backLight || (backLight != mWasBacklight)) {
					    Attention.backlight(backLight);
					    mWasBacklight = backLight;
					}
	    		}
            }
        }
    }
    
    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc) {
// manual says OBSCURITY values only valid here but template program puts them in onLayout
// modify it to call layout, once, from here
// garmin staff say in forum this issue is being looked at
		if (!mLaidOut) {
			mLaidOut = myLayout(dc);
		}
		
        // Set the background color
        View.findDrawableById("Background").setColor(getBackgroundColor());

        // Set the foreground color and value
        var labelView = View.findDrawableById("label");
       	var valueView = View.findDrawableById("value");
       	var meridiemView = View.findDrawableById("meridiem");
       	if (getBackgroundColor() == Graphics.COLOR_BLACK) {
            labelView.setColor(Graphics.COLOR_WHITE);
           	valueView.setColor(Graphics.COLOR_WHITE);
           	meridiemView.setColor(Graphics.COLOR_WHITE);
       	} else {
            labelView.setColor(Graphics.COLOR_BLACK);
           	valueView.setColor(Graphics.COLOR_BLACK);
           	meridiemView.setColor(Graphics.COLOR_BLACK);
       	}
        var useLabel = dc.getTextWidthInPixels(mLabel, Gfx.FONT_SMALL) >= mWidth ? mLabelAlt : mLabel;

       	labelView.setText(useLabel);
        valueView.setText(mValue);
        meridiemView.setText(mNoMeridiem ? "" : mMeridiem);

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }
}
