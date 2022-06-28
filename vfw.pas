unit vfw;

interface

uses
  Windows, MMSystem, Messages;





const
	// ------------------------------------------------------------------
	//  Window Messages  WM_CAP... which can be sent to an AVICAP window
	// ------------------------------------------------------------------

	// Defines start of the message range
	WM_CAP_START                    = WM_USER;

	WM_CAP_GET_CAPSTREAMPTR         = (WM_CAP_START+  1);
	WM_CAP_SET_CALLBACK_ERROR       = (WM_CAP_START+  2);
	WM_CAP_SET_CALLBACK_STATUS      = (WM_CAP_START+  3);
	WM_CAP_SET_CALLBACK_YIELD       = (WM_CAP_START+  4);
	WM_CAP_SET_CALLBACK_FRAME       = (WM_CAP_START+  5);
	WM_CAP_SET_CALLBACK_VIDEOSTREAM = (WM_CAP_START+  6);
	WM_CAP_SET_CALLBACK_WAVESTREAM  = (WM_CAP_START+  7);
	WM_CAP_GET_USER_DATA            = (WM_CAP_START+  8);
	WM_CAP_SET_USER_DATA            = (WM_CAP_START+  9);

	WM_CAP_DRIVER_CONNECT           = (WM_CAP_START+  10);
	WM_CAP_DRIVER_DISCONNECT        = (WM_CAP_START+  11);
	WM_CAP_DRIVER_GET_NAME          = (WM_CAP_START+  12);
	WM_CAP_DRIVER_GET_VERSION       = (WM_CAP_START+  13);
	WM_CAP_DRIVER_GET_CAPS          = (WM_CAP_START+  14);

	WM_CAP_FILE_SET_CAPTURE_FILE    = (WM_CAP_START+  20);
	WM_CAP_FILE_GET_CAPTURE_FILE    = (WM_CAP_START+  21);
	WM_CAP_FILE_ALLOCATE            = (WM_CAP_START+  22);
	WM_CAP_FILE_SAVEAS              = (WM_CAP_START+  23);
	WM_CAP_FILE_SET_INFOCHUNK       = (WM_CAP_START+  24);
	WM_CAP_FILE_SAVEDIB             = (WM_CAP_START+  25);

	WM_CAP_EDIT_COPY                = (WM_CAP_START+  30);

	WM_CAP_SET_AUDIOFORMAT          = (WM_CAP_START+  35);
	WM_CAP_GET_AUDIOFORMAT          = (WM_CAP_START+  36);

	WM_CAP_DLG_VIDEOFORMAT          = (WM_CAP_START+  41);
	WM_CAP_DLG_VIDEOSOURCE          = (WM_CAP_START+  42);
	WM_CAP_DLG_VIDEODISPLAY         = (WM_CAP_START+  43);
	WM_CAP_GET_VIDEOFORMAT          = (WM_CAP_START+  44);
	WM_CAP_SET_VIDEOFORMAT          = (WM_CAP_START+  45);
	WM_CAP_DLG_VIDEOCOMPRESSION     = (WM_CAP_START+  46);

	WM_CAP_SET_PREVIEW              = (WM_CAP_START+  50);
	WM_CAP_SET_OVERLAY              = (WM_CAP_START+  51);
	WM_CAP_SET_PREVIEWRATE          = (WM_CAP_START+  52);
	WM_CAP_SET_SCALE                = (WM_CAP_START+  53);
	WM_CAP_GET_STATUS               = (WM_CAP_START+  54);
	WM_CAP_SET_SCROLL               = (WM_CAP_START+  55);

	WM_CAP_GRAB_FRAME               = (WM_CAP_START+  60);
	WM_CAP_GRAB_FRAME_NOSTOP        = (WM_CAP_START+  61);

	WM_CAP_SEQUENCE                 = (WM_CAP_START+  62);
	WM_CAP_SEQUENCE_NOFILE          = (WM_CAP_START+  63);
	WM_CAP_SET_SEQUENCE_SETUP       = (WM_CAP_START+  64);
	WM_CAP_GET_SEQUENCE_SETUP       = (WM_CAP_START+  65);
	WM_CAP_SET_MCI_DEVICE           = (WM_CAP_START+  66);
	WM_CAP_GET_MCI_DEVICE           = (WM_CAP_START+  67);
	WM_CAP_STOP                     = (WM_CAP_START+  68);
	WM_CAP_ABORT                    = (WM_CAP_START+  69);

	WM_CAP_SINGLE_FRAME_OPEN        = (WM_CAP_START+  70);
	WM_CAP_SINGLE_FRAME_CLOSE       = (WM_CAP_START+  71);
	WM_CAP_SINGLE_FRAME             = (WM_CAP_START+  72);

	WM_CAP_PAL_OPEN                 = (WM_CAP_START+  80);
	WM_CAP_PAL_SAVE                 = (WM_CAP_START+  81);
	WM_CAP_PAL_PASTE                = (WM_CAP_START+  82);
	WM_CAP_PAL_AUTOCREATE           = (WM_CAP_START+  83);
	WM_CAP_PAL_MANUALCREATE         = (WM_CAP_START+  84);

		// Following added post VFW 1.1
	WM_CAP_SET_CALLBACK_CAPCONTROL  = (WM_CAP_START+  85);

	// Defines end of the message range
	WM_CAP_END                      = WM_CAP_SET_CALLBACK_CAPCONTROL;

// dwFlags field of TVIDEOHDR
VHDR_DONE =      $00000001;  // Done bit */
VHDR_PREPARED=   $00000002;  // Set if this header has been prepared */
VHDR_INQUEUE =   $00000004;  // Reserved for driver */
VHDR_KEYFRAME=   $00000008;  // Key Frame */

// ------------------------------------------------------------------
//  Structures
// ------------------------------------------------------------------


type
 PCapDriverCaps = ^TCapDriverCaps;
 TCapDriverCaps = record
    wDeviceIndex            :WORD;           // Driver index in system.ini
    fHasOverlay             :BOOL;           // Can device overlay?
    fHasDlgVideoSource      :BOOL;           // Has Video source dlg?
    fHasDlgVideoFormat      :BOOL;           // Has Format dlg?
    fHasDlgVideoDisplay     :BOOL;           // Has External out dlg?
    fCaptureInitialized     :BOOL;           // Driver ready to capture?
    fDriverSuppliesPalettes :BOOL;           // Can driver make palettes?
    hVideoIn                :THANDLE;        // Driver In channel
    hVideoOut               :THANDLE;        // Driver Out channel
    hVideoExtIn             :THANDLE;        // Driver Ext In channel
    hVideoExtOut            :THANDLE;        // Driver Ext Out channel
end;

  pCapStatus = ^TCapStatus;
  TCapStatus = record
    uiImageWidth                :UINT;      // Width of the image
    uiImageHeight               :UINT;      // Height of the image
    fLiveWindow                 :BOOL;      // Now Previewing video?
    fOverlayWindow              :BOOL;      // Now Overlaying video?
    fScale                      :BOOL;      // Scale image to client?
    ptScroll                    :TPOINT;    // Scroll position
    fUsingDefaultPalette        :BOOL;      // Using default driver palette?
    fAudioHardware              :BOOL;      // Audio hardware present?
    fCapFileExists              :BOOL;      // Does capture file exist?
    dwCurrentVideoFrame         :DWORD;     // # of video frames cap'td
    dwCurrentVideoFramesDropped :DWORD;     // # of video frames dropped
    dwCurrentWaveSamples        :DWORD;     // # of wave samples cap'td
    dwCurrentTimeElapsedMS      :DWORD;     // Elapsed capture duration
    hPalCurrent                 :HPALETTE;  // Current palette in use
    fCapturingNow               :BOOL;      // Capture in progress?
    dwReturn                    :DWORD;     // Error value after any operation
    wNumVideoAllocated          :UINT;      // Actual number of video buffers
    wNumAudioAllocated          :UINT;      // Actual number of audio buffers
 end;


pCaptureParms = ^TCaptureParms;
 TCaptureParms = record                    // Default values in parenthesis
   dwRequestMicroSecPerFrame  :DWORD;      // Requested capture rate
   fMakeUserHitOKToCapture    :BOOL;       // Show "Hit OK to cap" dlg?
   wPercentDropForError       :UINT;       // Give error msg if > (10%)
   fYield                     :BOOL;       // Capture via background task?
   dwIndexSize                :DWORD;      // Max index size in frames (32K)
   wChunkGranularity          :UINT;       // Junk chunk granularity (2K)
   fUsingDOSMemory            :BOOL;       // Use DOS buffers?
   wNumVideoRequested         :UINT;       // # video buffers, If 0, autocalc
   fCaptureAudio              :BOOL;       // Capture audio?
   wNumAudioRequested         :UINT;       // # audio buffers, If 0, autocalc
   vKeyAbort                  :UINT;       // Virtual key causing abort
   fAbortLeftMouse            :BOOL;       // Abort on left mouse?
   fAbortRightMouse           :BOOL;       // Abort on right mouse?
   fLimitEnabled              :BOOL;       // Use wTimeLimit?
   wTimeLimit                 :UINT;       // Seconds to capture
   fMCIControl                :BOOL;       // Use MCI video source?
   fStepMCIDevice             :BOOL;       // Step MCI device?
   dwMCIStartTime             :DWORD;      // Time to start in MS
   dwMCIStopTime              :DWORD;     // Time to stop in MS
   fStepCaptureAt2x           :BOOL;      // Perform spatial averaging 2x
   wStepCaptureAverageFrames  :UINT;      // Temporal average n Frames
   dwAudioBufferSize          :DWORD;     // Size of audio bufs (0 = default)
   fDisableWriteCache         :BOOL;     // Attempt to disable write cache
   AVStreamMaster             :UINT;     // Which stream controls length?
end;

 PCapInfoChunk = ^TCapInfoChunk;
 TCapInfoChunk = record
    fccInfoID :FOURCC; 		// Chunk ID, "ICOP" for copyright
    lpData    :Pointer; 	// pointer to data
    cbData    :LongInt;         // size of lpData
end;

PVIDEOHDR = ^TVIDEOHDR;
TVIDEOHDR = record
    lpData:pByte;                 // pointer to locked data buffer
    dwBufferLength:DWORD;         // Length of data buffer
    dwBytesUsed:DWORD;            // Bytes actually used
    dwTimeCaptured:DWORD;         // Milliseconds from start of stream
    dwUser:DWORD;                 // for client's use
    dwFlags:DWORD;                // assorted flags (see defines)
    dwReserved: array [0..4] of DWORD;    // reserved for driver
end;



// ------------------------------------------------------------------
//  Callback Definitions
// ------------------------------------------------------------------
type
	TCAPSTATUSCALLBACK  = function(hWnd:HWND; nID:Integer; lpsz:PChar):LongInt; stdcall;
	TCAPYIELDCALLBACK   = function(hWnd:HWND):LongInt; stdcall;
	TCAPERRORCALLBACK   = function(hWnd:HWND; nID:Integer; lpsz:Pchar):LongInt; stdcall;
	TCAPVIDEOSTREAMCALLBACK = function(hWnd:HWND; lpVHdr:PVIDEOHDR):LongInt; stdcall;
	TCAPWAVESTREAMCALLBACK   = function(hWnd:HWND; lpWHdr:PWAVEHDR):LongInt; stdcall;
	TCAPCONTROLCALLBACK = function(hWnd:HWND; nState:Integer):LongInt; stdcall;
	// ------------------------------------------------------------------
	//  CapControlCallback states
	// ------------------------------------------------------------------
Const
	CONTROLCALLBACK_PREROLL         = 1;	// Waiting to start capture
	CONTROLCALLBACK_CAPTURING       = 2; 	// Now capturing





	// ------------------------------------------------------------------
	//  Message crackers for above
	// ------------------------------------------------------------------
function capSetCallbackOnError (hwnd : THandle; fpProc:TCAPERRORCALLBACK):LongInt;
function capSetCallbackOnStatus(hwnd : THandle; fpProc:TCAPSTATUSCALLBACK):LongInt;
function capSetCallbackOnYield (hwnd : THandle; fpProc:TCAPYIELDCALLBACK):LongInt;
function capSetCallbackOnFrame (hwnd : THandle; fpProc:TCAPVIDEOSTREAMCALLBACK):LongInt;  // Hier ist der Type der Callbackfunktion nicht klar !
function capSetCallbackOnVideoStream(hwnd:THandle; fpProc:TCAPVIDEOSTREAMCALLBACK):LongInt;
function capSetCallbackOnWaveStream (hwnd:THandle; fpProc: TCAPWAVESTREAMCALLBACK):LongInt;
function capSetCallbackOnCapControl (hwnd:THandle; fpProc:TCAPCONTROLCALLBACK):LongInt;


function capSetUserData(hwnd:THandle; lUser:LongInt):LongInt;
function capGetUserData(hwnd:THandle):LongInt;

function capDriverConnect(hwnd:THandle; I: Word) : boolean;
function capDriverDisconnect(hwnd:THandle):boolean;

function capDriverGetName(hwnd:THandle; szName:PChar; wSize:Word):boolean;
function capDriverGetVersion(hwnd:THandle; szVer:PChar; wSize:Word):Boolean;
function capDriverGetCaps(hwnd:THandle; s:PCapDriverCaps; wSize:Word):boolean;

function capFileSetCaptureFile(hwnd:THandle; szName:PChar):boolean;
function capFileGetCaptureFile(hwnd:THandle; szName:PChar; wSize:Word):boolean;
function capFileAlloc(hwnd:THandle; dwSize:DWORD):boolean;
function capFileSaveAs(hwnd:THandle; szName:Pchar):boolean;
function capFileSetInfoChunk(hwnd:THandle; lpInfoChunk:pCapInfoChunk):boolean ;
function capFileSaveDIB(hwnd:THandle; szName:Pchar):boolean;

function capEditCopy(hwnd : THandle):boolean;

function capSetAudioFormat(hwnd:THandle; s:PWaveFormatEx; wSize:Word):Boolean;
function capGetAudioFormat(hwnd:THandle; s:PWaveFormatEx; wSize:Word):DWORD;
function capGetAudioFormatSize(hwnd:THandle):DWORD;

function capDlgVideoFormat(hwnd:THandle):boolean;
function capDlgVideoSource(hwnd:THandle):boolean;
function capDlgVideoDisplay(hwnd:THandle):boolean;
function capDlgVideoCompression(hwnd:THandle):boolean;

function capGetVideoFormat(hwnd:THandle; s:pBitmapInfo; wSize:Word):DWord;
function capGetVideoFormatSize(hwnd:THandle):DWORD;

function capSetVideoFormat(hwnd:THandle; s:pBitmapInfo; wSize:Word):boolean;

function capPreview(hwnd:THandle; f:boolean):boolean;
function capPreviewRate(hwnd:THandle; wMS:Word):boolean;
function capOverlay(hwnd:THandle; f:boolean):boolean;
function capPreviewScale(hwnd:THandle; f:boolean):boolean;
function capGetStatus(hwnd:THandle; s:pCapStatus; wSize:Word):boolean;
function capSetScrollPos(hwnd:THandle; lpP:pPoint):boolean;

function capGrabFrame(hwnd:THandle):boolean;
function capGrabFrameNoStop(hwnd:THandle):boolean;

function capCaptureSequence(hwnd:THandle):Boolean;
function capCaptureSequenceNoFile(hwnd:THandle):Boolean;
function capCaptureStop(hwnd:THandle):boolean;
function capCaptureAbort(hwnd:THandle):boolean;

function capCaptureSingleFrameOpen(hwnd:THandle):boolean;
function capCaptureSingleFrameClose(hwnd:THandle):boolean;
function capCaptureSingleFrame(hwnd:THandle):boolean;

function capCaptureGetSetup(hwnd:THandle; s:pCaptureParms; wSize:Word):boolean;
function capCaptureSetSetup(hwnd:THandle; s:pCaptureParms; wSize:Word):boolean;

function capSetMCIDeviceName(hwnd:THandle; szName:PChar):boolean;
function capGetMCIDeviceName(hwnd:THandle; szName:PChar; wSize:Word):boolean;

function capPaletteOpen(hwnd:THandle; szName:PChar):boolean;
function capPaletteSave(hwnd:THandle; szName:PChar):boolean;
function capPalettePaste(hwnd:THandle):Boolean;
function capPaletteAuto(hwnd:THandle; iFrames:Word; iColors:word):boolean;
function capPaletteManual(hwnd:THandle; fGrab:Word; iColors:word):boolean;






	// ------------------------------------------------------------------
	//  The only exported functions from AVICAP.DLL
	// ------------------------------------------------------------------
  function capCreateCaptureWindow (
	  	      lpszWindowName  : PChar;
                      dwStyle         : DWord;
     	  	      x, y            : Integer;
		      nWidth, nHeight : Integer;
    		      hwndParent      : THandle;
        	      nID             : Integer ) : THandle; stdcall;

 function capGetDriverDescription (
  		    	wDriverIndex : DWord;
		        lpszName     : PChar;
		        cbName       : Integer;
		        lpszVer      : PChar;
		        cbVer        : Integer ) : Boolean; stdcall;

	// ------------------------------------------------------------------
	// New Information chunk IDs
	// ------------------------------------------------------------------
(*
	infotypeDIGITIZATION_TIME  = mmioStringToFOURCC(PChar('IDIT'), MMIO_TOUPPER);
	infotypeSMPTE_TIME         = mmioStringToFOURCC(PChar('ISMP'), MMIO_TOUPPER);
*)

	// ------------------------------------------------------------------
	// String IDs from status and error callbacks
	// ------------------------------------------------------------------
Const
	IDS_CAP_BEGIN               = 300; (* "Capture Start" *)
	IDS_CAP_END                 = 301; (* "Capture End" *)

	IDS_CAP_INFO                = 401; (* "%s" *)
	IDS_CAP_OUTOFMEM            = 402; (* "Out of memory" *)
	IDS_CAP_FILEEXISTS          = 403; (* "File '%s' exists -- overwrite it?" *)
	IDS_CAP_ERRORPALOPEN        = 404; (* "Error opening palette '%s'" *)
	IDS_CAP_ERRORPALSAVE        = 405; (* "Error saving palette '%s'" *)
	IDS_CAP_ERRORDIBSAVE        = 406; (* "Error saving frame '%s'" *)
	IDS_CAP_DEFAVIEXT           = 407; (* "avi" *)
	IDS_CAP_DEFPALEXT           = 408; (* "pal" *)
	IDS_CAP_CANTOPEN            = 409; (* "Cannot open '%s'" *)
	IDS_CAP_SEQ_MSGSTART        = 410; (* "Select OK to start capture\nof video sequence\nto %s." *)
	IDS_CAP_SEQ_MSGSTOP         = 411; (* "Hit ESCAPE or click to end capture" *)

	IDS_CAP_VIDEDITERR          = 412; (* "An error occurred while trying to run VidEdit." *)
	IDS_CAP_READONLYFILE        = 413; (* "The file '%s' is a read-only file." *)
	IDS_CAP_WRITEERROR          = 414; (* "Unable to write to file '%s'.\nDisk may be full." *)
	IDS_CAP_NODISKSPACE         = 415; (* "There is no space to create a capture file on the specified device." *)
	IDS_CAP_SETFILESIZE         = 416; (* "Set File Size" *)
	IDS_CAP_SAVEASPERCENT       = 417; (* "SaveAs: %2ld%%  Hit Escape to abort." *)

	IDS_CAP_DRIVER_ERROR        = 418; (* Driver specific error message *)

	IDS_CAP_WAVE_OPEN_ERROR     = 419; (* "Error: Cannot open the wave input device.\nCheck sample size, frequency, and channels." *)
	IDS_CAP_WAVE_ALLOC_ERROR    = 420; (* "Error: Out of memory for wave buffers." *)
	IDS_CAP_WAVE_PREPARE_ERROR  = 421; (* "Error: Cannot prepare wave buffers." *)
	IDS_CAP_WAVE_ADD_ERROR      = 422; (* "Error: Cannot add wave buffers." *)
	IDS_CAP_WAVE_SIZE_ERROR     = 423; (* "Error: Bad wave size." *)

	IDS_CAP_VIDEO_OPEN_ERROR    = 424; (* "Error: Cannot open the video input device." *)
	IDS_CAP_VIDEO_ALLOC_ERROR   = 425; (* "Error: Out of memory for video buffers." *)
	IDS_CAP_VIDEO_PREPARE_ERROR = 426; (* "Error: Cannot prepare video buffers." *)
	IDS_CAP_VIDEO_ADD_ERROR     = 427; (* "Error: Cannot add video buffers." *)
	IDS_CAP_VIDEO_SIZE_ERROR    = 428; (* "Error: Bad video size." *)

	IDS_CAP_FILE_OPEN_ERROR     = 429; (* "Error: Cannot open capture file." *)
	IDS_CAP_FILE_WRITE_ERROR    = 430; (* "Error: Cannot write to capture file.  Disk may be full." *)
	IDS_CAP_RECORDING_ERROR     = 431; (* "Error: Cannot write to capture file.  Data rate too high or disk full." *)
	IDS_CAP_RECORDING_ERROR2    = 432; (* "Error while recording" *)
	IDS_CAP_AVI_INIT_ERROR      = 433; (* "Error: Unable to initialize for capture." *)
	IDS_CAP_NO_FRAME_CAP_ERROR  = 434; (* "Warning: No frames captured.\nConfirm that vertical sync interrupts\nare configured and enabled." *)
	IDS_CAP_NO_PALETTE_WARN     = 435; (* "Warning: Using default palette." *)
	IDS_CAP_MCI_CONTROL_ERROR   = 436; (* "Error: Unable to access MCI device." *)
	IDS_CAP_MCI_CANT_STEP_ERROR = 437; (* "Error: Unable to step MCI device." *)
	IDS_CAP_NO_AUDIO_CAP_ERROR  = 438; (* "Error: No audio data captured.\nCheck audio card settings." *)
	IDS_CAP_AVI_DRAWDIB_ERROR   = 439; (* "Error: Unable to draw this data format." *)
	IDS_CAP_COMPRESSOR_ERROR    = 440; (* "Error: Unable to initialize compressor." *)
	IDS_CAP_AUDIO_DROP_ERROR    = 441; (* "Error: Audio data was lost during capture, reduce capture rate." *)

  (* status string IDs *)
	IDS_CAP_STAT_LIVE_MODE      = 500; (* "Live window" *)
	IDS_CAP_STAT_OVERLAY_MODE   = 501; (* "Overlay window" *)
	IDS_CAP_STAT_CAP_INIT       = 502; (* "Setting up for capture - Please wait" *)
	IDS_CAP_STAT_CAP_FINI       = 503; (* "Finished capture, now writing frame %ld" *)
	IDS_CAP_STAT_PALETTE_BUILD  = 504; (* "Building palette map" *)
	IDS_CAP_STAT_OPTPAL_BUILD   = 505; (* "Computing optimal palette" *)
	IDS_CAP_STAT_I_FRAMES       = 506; (* "%d frames" *)
	IDS_CAP_STAT_L_FRAMES       = 507; (* "%ld frames" *)
	IDS_CAP_STAT_CAP_L_FRAMES   = 508; (* "Captured %ld frames" *)
	IDS_CAP_STAT_CAP_AUDIO      = 509; (* "Capturing audio" *)
	IDS_CAP_STAT_VIDEOCURRENT   = 510; (* "Captured %ld frames (%ld dropped) %d.%03d sec." *)
	IDS_CAP_STAT_VIDEOAUDIO     = 511; (* "Captured %d.%03d sec.  %ld frames (%ld dropped) (%d.%03d fps).  %ld audio bytes (%d,%03d sps)" *)
	IDS_CAP_STAT_VIDEOONLY      = 512; (* "Captured %d.%03d sec.  %ld frames (%ld dropped) (%d.%03d fps)" *)
	IDS_CAP_STAT_FRAMESDROPPED  = 513; (* "Dropped %ld of %ld frames (%d.%02d%%) during capture." *)



  {== DRAWDIB - Routines for drawing to the display ============================}

type
    HDRAWDIB                    = THandle;  // hdd


{ == DrawDib Flags ============================================================}

const
    DDF_UPDATE                  = $0002;    // re-draw the last DIB
    DDF_SAME_HDC                = $0004;    // HDC same as last call (all setup)
    DDF_SAME_DRAW               = $0008;    // draw params are the same
    DDF_DONTDRAW                = $0010;    // dont draw frame, just decompress
    DDF_ANIMATE                 = $0020;    // allow palette animation
    DDF_BUFFER                  = $0040;    // always buffer image
    DDF_JUSTDRAWIT              = $0080;    // just draw it with GDI
    DDF_FULLSCREEN              = $0100;    // use DisplayDib
    DDF_BACKGROUNDPAL           = $0200;    // Realize palette in background
    DDF_NOTKEYFRAME             = $0400;    // this is a partial frame update, hint
    DDF_HURRYUP                 = $0800;    // hurry up please!
    DDF_HALFTONE                = $1000;    // always halftone

    DDF_PREROLL                 = DDF_DONTDRAW; // Builing up a non-keyframe
    DDF_SAME_DIB                = DDF_SAME_DRAW;
    DDF_SAME_SIZE               = DDF_SAME_DRAW;

{== DrawDib functions ========================================================}

{-- DrawDibOpen() ------------------------------------------------------------}

function    DrawDibOpen: HDRAWDIB; stdcall;

{-- DrawDibClose() -----------------------------------------------------------}

function    DrawDibClose(hdd: HDRAWDIB): BOOL; stdcall;

{-- DrawDibGetBuffer() -------------------------------------------------------}

function    DrawDibGetBuffer(hdd: HDRAWDIB; lpbi: PBITMAPINFOHEADER; dwSize: DWORD; dwFlags: DWORD): Pointer;stdcall;

{-- DrawDibGetPalette() - get the palette used for drawing DIBs --------------}

function    DrawDibGetPalette(hdd: HDRAWDIB): HPALETTE; stdcall;

{-- DrawDibSetPalette() - set the palette used for drawing DIBs --------------}

function    DrawDibSetPalette(hdd: HDRAWDIB; hpal: HPALETTE): BOOL; stdcall;

{-- DrawDibChangePalette() ---------------------------------------------------}

function    DrawDibChangePalette(hdd: HDRAWDIB; iStart, iLen: integer; lppe: PPALETTEENTRY): BOOL; stdcall;

{-- DrawDibRealize() - realize the palette in a HDD --------------------------}

function    DrawDibRealize(hdd: HDRAWDIB; hdc: HDC; fBackground: BOOL): UINT; stdcall;

{-- DrawDibStart() - start of streaming playback -----------------------------}

function    DrawDibStart(hdd: HDRAWDIB; rate: DWORD): BOOL; stdcall;

{-- DrawDibStop() - start of streaming playback ------------------------------}

function    DrawDibStop(hdd: HDRAWDIB): BOOL; stdcall;

{-- DrawDibBegin() - prepare to draw -----------------------------------------}

function    DrawDibBegin(
    hdd         : HDRAWDIB;
    hdc         : HDC;
    dxDst       : integer;
    dyDst       : integer;
    lpbi        : PBITMAPINFOHEADER;
    dxSrc       : integer;
    dySrc       : integer;
    wFlags      : UINT
    ): BOOL; stdcall;

{-- DrawDibDraw() - actually draw a DIB to the screen ------------------------}

function    DrawDibDraw(
    hdd         : HDRAWDIB;
    hdc         : HDC;
    xDst        : integer;
    yDst        : integer;
    dxDst       : integer;
    dyDst       : integer;
    lpbi        : PBITMAPINFOHEADER;
    lpBits      : Pointer;
    xSrc        : integer;
    ySrc        : integer;
    dxSrc       : integer;
    dySrc       : integer;
    wFlags      : UINT
    ): BOOL; stdcall;

{-- DrawDibUpdate() - redraw last image (may only be valid with DDF_BUFFER) --}

//function    DrawDibUpdate(hdd: HDRAWDIB; hdc: HDC; x, y: integer): BOOL;stdcall;

{-- DrawDibEnd() -------------------------------------------------------------}

function    DrawDibEnd(hdd: HDRAWDIB): BOOL; stdcall;

{-- DrawDibTime() - for debugging purposes only ------------------------------}

type
    PDRAWDIBTIME        = ^TDRAWDIBTIME;
    TDRAWDIBTIME        = record
        timeCount       : DWORD;
        timeDraw        : DWORD;
        timeDecompress  : DWORD;
        timeDither      : DWORD;
        timeStretch     : DWORD;
        timeBlt         : DWORD;
        timeSetDIBits   : DWORD;
    end;

function    DrawDibTime(hdd: HDRAWDIB; lpddtime: PDRAWDIBTIME): BOOL; stdcall;

{-- Display profiling --------------------------------------------------------}

const
    PD_CAN_DRAW_DIB             = $0001;    // if you can draw at all
    PD_CAN_STRETCHDIB           = $0002;    // basicly RC_STRETCHDIB
    PD_STRETCHDIB_1_1_OK        = $0004;    // is it fast?
    PD_STRETCHDIB_1_2_OK        = $0008;    // ...
    PD_STRETCHDIB_1_N_OK        = $0010;    // ...

function    DrawDibProfileDisplay(lpbi: PBITMAPINFOHEADER): DWORD; stdcall;

// Helper fucntion for FOURCC

function MKFOURCC(ch0, ch1, ch2, ch3: Char): FOURCC;

{== COMPMAN - Installable Compression Manager ================================}

const
    ICVERSION                   = $0104 ;

type
    HIC                         = THandle;  // Handle to an Installable Compressor

//
// this code in biCompression means the DIB must be accesed via
// 48 bit pointers! using *ONLY* the selector given.
//
const
    BI_1632                     = $32333631;    // '1632'

function    mmioFOURCC(ch0, ch1, ch2, ch3: Char): FOURCC;

type
    TWOCC                       = Word;

function    aviTWOCC(ch0, ch1: Char): TWOCC;

const
    ICTYPE_VIDEO                = $63646976; // mmioFOURCC('v', 'i', 'd', 'c')
    ICTYPE_AUDIO                = $63647561; // mmioFOURCC('a', 'u', 'd', 'c')

const
    ICERR_OK                    = 0 ;
    ICERR_DONTDRAW              = 1 ;
    ICERR_NEWPALETTE            = 2 ;
    ICERR_GOTOKEYFRAME          = 3 ;
    ICERR_STOPDRAWING           = 4 ;

    ICERR_UNSUPPORTED           = -1 ;
    ICERR_BADFORMAT             = -2 ;
    ICERR_MEMORY                = -3 ;
    ICERR_INTERNAL              = -4 ;
    ICERR_BADFLAGS              = -5 ;
    ICERR_BADPARAM              = -6 ;
    ICERR_BADSIZE               = -7 ;
    ICERR_BADHANDLE             = -8 ;
    ICERR_CANTUPDATE            = -9 ;
    ICERR_ABORT                 = -10 ;
    ICERR_ERROR                 = -100 ;
    ICERR_BADBITDEPTH           = -200 ;
    ICERR_BADIMAGESIZE          = -201 ;

    ICERR_CUSTOM                = -400 ;    // errors less than ICERR_CUSTOM...

{-- Values for dwFlags of ICOpen() -------------------------------------------}

    ICMODE_COMPRESS             = 1 ;
    ICMODE_DECOMPRESS           = 2 ;
    ICMODE_FASTDECOMPRESS       = 3 ;
    ICMODE_QUERY                = 4 ;
    ICMODE_FASTCOMPRESS         = 5 ;
    ICMODE_DRAW                 = 8 ;

{-- Flags for AVI file index -------------------------------------------------}

    AVIIF_LIST                  = $00000001 ;
    AVIIF_TWOCC                 = $00000002 ;
    AVIIF_KEYFRAME              = $00000010 ;

{-- quality flags ------------------------------------------------------------}

    ICQUALITY_LOW               = 0 ;
    ICQUALITY_HIGH              = 10000 ;
    ICQUALITY_DEFAULT           = -1 ;

{-----------------------------------------------------------------------------}

    ICM_USER                    = (DRV_USER+$0000) ;

    ICM_RESERVED_LOW            = (DRV_USER+$1000) ;
    ICM_RESERVED_HIGH           = (DRV_USER+$2000) ;
    ICM_RESERVED                = ICM_RESERVED_LOW ;

{-- Messages -----------------------------------------------------------------}

    ICM_GETSTATE                = (ICM_RESERVED+0) ;    // Get compressor state
    ICM_SETSTATE                = (ICM_RESERVED+1) ;    // Set compressor state
    ICM_GETINFO                 = (ICM_RESERVED+2) ;    // Query info about the compressor

    ICM_CONFIGURE               = (ICM_RESERVED+10);    // show the configure dialog
    ICM_ABOUT                   = (ICM_RESERVED+11);    // show the about box

    ICM_GETDEFAULTQUALITY       = (ICM_RESERVED+30);    // get the default value for quality
    ICM_GETQUALITY              = (ICM_RESERVED+31);    // get the current value for quality
    ICM_SETQUALITY              = (ICM_RESERVED+32);    // set the default value for quality

    ICM_SET                     = (ICM_RESERVED+40);    // Tell the driver something
    ICM_GET                     = (ICM_RESERVED+41);    // Ask the driver something

{-- Constants for ICM_SET: ---------------------------------------------------}

    ICM_FRAMERATE               = $526D7246; // mmioFOURCC('F','r','m','R')
    ICM_KEYFRAMERATE            = $5279654B; // mmioFOURCC('K','e','y','R')

{-- ICM specific messages ----------------------------------------------------}

    ICM_COMPRESS_GET_FORMAT     = (ICM_USER+4)  ;   // get compress format or size
    ICM_COMPRESS_GET_SIZE       = (ICM_USER+5)  ;   // get output size
    ICM_COMPRESS_QUERY          = (ICM_USER+6)  ;   // query support for compress
    ICM_COMPRESS_BEGIN          = (ICM_USER+7)  ;   // begin a series of compress calls.
    ICM_COMPRESS                = (ICM_USER+8)  ;   // compress a frame
    ICM_COMPRESS_END            = (ICM_USER+9)  ;   // end of a series of compress calls.

    ICM_DECOMPRESS_GET_FORMAT   = (ICM_USER+10) ;   // get decompress format or size
    ICM_DECOMPRESS_QUERY        = (ICM_USER+11) ;   // query support for dempress
    ICM_DECOMPRESS_BEGIN        = (ICM_USER+12) ;   // start a series of decompress calls
    ICM_DECOMPRESS              = (ICM_USER+13) ;   // decompress a frame
    ICM_DECOMPRESS_END          = (ICM_USER+14) ;   // end a series of decompress calls
    ICM_DECOMPRESS_SET_PALETTE  = (ICM_USER+29) ;   // fill in the DIB color table
    ICM_DECOMPRESS_GET_PALETTE  = (ICM_USER+30) ;   // fill in the DIB color table

    ICM_DRAW_QUERY              = (ICM_USER+31) ;   // query support for dempress
    ICM_DRAW_BEGIN              = (ICM_USER+15) ;   // start a series of draw calls
    ICM_DRAW_GET_PALETTE        = (ICM_USER+16) ;   // get the palette needed for drawing
    ICM_DRAW_START              = (ICM_USER+18) ;   // start decompress clock
    ICM_DRAW_STOP               = (ICM_USER+19) ;   // stop decompress clock
    ICM_DRAW_END                = (ICM_USER+21) ;   // end a series of draw calls
    ICM_DRAW_GETTIME            = (ICM_USER+32) ;   // get value of decompress clock
    ICM_DRAW                    = (ICM_USER+33) ;   // generalized "render" message
    ICM_DRAW_WINDOW             = (ICM_USER+34) ;   // drawing window has moved or hidden
    ICM_DRAW_SETTIME            = (ICM_USER+35) ;   // set correct value for decompress clock
    ICM_DRAW_REALIZE            = (ICM_USER+36) ;   // realize palette for drawing
    ICM_DRAW_FLUSH              = (ICM_USER+37) ;   // clear out buffered frames
    ICM_DRAW_RENDERBUFFER       = (ICM_USER+38) ;   // draw undrawn things in queue

    ICM_DRAW_START_PLAY         = (ICM_USER+39) ;   // start of a play
    ICM_DRAW_STOP_PLAY          = (ICM_USER+40) ;   // end of a play

    ICM_DRAW_SUGGESTFORMAT      = (ICM_USER+50) ;   // Like ICGetDisplayFormat
    ICM_DRAW_CHANGEPALETTE      = (ICM_USER+51) ;   // for animating palette

    ICM_GETBUFFERSWANTED        = (ICM_USER+41) ;   // ask about prebuffering

    ICM_GETDEFAULTKEYFRAMERATE  = (ICM_USER+42) ;   // get the default value for key frames

    ICM_DECOMPRESSEX_BEGIN      = (ICM_USER+60) ;   // start a series of decompress calls
    ICM_DECOMPRESSEX_QUERY      = (ICM_USER+61) ;   // start a series of decompress calls
    ICM_DECOMPRESSEX            = (ICM_USER+62) ;   // decompress a frame
    ICM_DECOMPRESSEX_END        = (ICM_USER+63) ;   // end a series of decompress calls

    ICM_COMPRESS_FRAMES_INFO    = (ICM_USER+70) ;   // tell about compress to come
    ICM_SET_STATUS_PROC         = (ICM_USER+72) ;   // set status callback

{-----------------------------------------------------------------------------}

type
    PICOPEN                     = ^TICOPEN;
    TICOPEN                     = record
        dwSize                  : DWORD   ; // sizeof(TICOPEN)
        fccType                 : DWORD   ; // 'vidc'
        fccHandler              : DWORD   ; //
        dwVersion               : DWORD   ; // version of compman opening you
        dwFlags                 : DWORD   ; // LOWORD is type specific
        dwError                 : DWORD   ; // error return.
        pV1Reserved             : Pointer   ; // Reserved
        pV2Reserved             : Pointer   ; // Reserved
        dnDevNode               : DWORD   ; // Devnode for PnP devices
    end;

{-----------------------------------------------------------------------------}

    PICINFO                     = ^TICINFO ;
    TICINFO                     = record
        dwSize                  : DWORD;    // sizeof(TICINFO)
        fccType                 : DWORD;    // compressor type     'vidc' 'audc'
        fccHandler              : DWORD;    // compressor sub-type 'rle ' 'jpeg' 'pcm '
        dwFlags                 : DWORD;    // flags LOWORD is type specific
        dwVersion               : DWORD;    // version of the driver
        dwVersionICM            : DWORD;    // version of the ICM used
        //
        // under Win32, the driver always returns UNICODE strings.
        //
        szName                  : array[0..15] of WideChar  ; // short name
        szDescription           : array[0..127] of WideChar ; // DWORD name
        szDriver                : array[0..127] of WideChar ; // driver that contains compressor
    end;

{-- Flags for the <dwFlags> field of the <ICINFO> structure. -----------------}

const
    VIDCF_QUALITY               = $0001 ;  // supports quality
    VIDCF_CRUNCH                = $0002 ;  // supports crunching to a frame size
    VIDCF_TEMPORAL              = $0004 ;  // supports inter-frame compress
    VIDCF_COMPRESSFRAMES        = $0008 ;  // wants the compress all frames message
    VIDCF_DRAW                  = $0010 ;  // supports drawing
    VIDCF_FASTTEMPORALC         = $0020 ;  // does not need prev frame on compress
    VIDCF_FASTTEMPORALD         = $0080 ;  // does not need prev frame on decompress
    //VIDCF_QUALITYTIME         = $0040 ;  // supports temporal quality

    //VIDCF_FASTTEMPORAL        = (VIDCF_FASTTEMPORALC or VIDCF_FASTTEMPORALD)

{-----------------------------------------------------------------------------}

    ICCOMPRESS_KEYFRAME         = $00000001;

type
    PICCOMPRESS                 = ^TICCOMPRESS;
    TICCOMPRESS                 = record
        dwFlags                 : DWORD;                // flags

        lpbiOutput              : PBITMAPINFOHEADER ;   // output format
        lpOutput                : Pointer ;               // output data

        lpbiInput               : PBITMAPINFOHEADER ;   // format of frame to compress
        lpInput                 : Pointer ;               // frame data to compress

        lpckid                  : PDWORD ;              // ckid for data in AVI file
        lpdwFlags               : PDWORD;               // flags in the AVI index.
        lFrameNum               : DWORD ;                // frame number of seq.
        dwFrameSize             : DWORD ;               // reqested size in bytes. (if non zero)

        dwQuality               : DWORD ;               // quality

        // these are new fields

        lpbiPrev                : PBITMAPINFOHEADER ;   // format of previous frame
        lpPrev                  : Pointer ;              // previous frame
    end;

{-----------------------------------------------------------------------------}

const
    ICCOMPRESSFRAMES_PADDING    = $00000001 ;

type
    TICCompressProc             = function(lInput: LPARAM; lFrame: DWORD; lpBits: Pointer; len: DWORD): DWORD; stdcall;

    PICCOMPRESSFRAMES           = ^TICCOMPRESSFRAMES;
    TICCOMPRESSFRAMES           = record
        dwFlags                 : DWORD ;               // flags

        lpbiOutput              : PBITMAPINFOHEADER ;   // output format
        lOutput                 : LPARAM ;              // output identifier

        lpbiInput               : PBITMAPINFOHEADER ;   // format of frame to compress
        lInput                  : LPARAM ;              // input identifier

        lStartFrame             : DWORD ;                // start frame
        lFrameCount             : DWORD ;                // # of frames

        lQuality                : DWORD ;                // quality
        lDataRate               : DWORD ;                // data rate
        lKeyRate                : DWORD ;                // key frame rate

        dwRate                  : DWORD ;               // frame rate, as always
        dwScale                 : DWORD ;

        dwOverheadPerFrame      : DWORD ;
        dwReserved2             : DWORD ;

        GetData                 : TICCompressProc;
        PutData                 : TICCompressProc;
    end;

{-- Messages for Status callback ---------------------------------------------}

const
    ICSTATUS_START              = 0 ;
    ICSTATUS_STATUS             = 1 ;   // l = % done
    ICSTATUS_END                = 2 ;
    ICSTATUS_ERROR              = 3 ;   // l = error string (LPSTR)
    ICSTATUS_YIELD              = 4 ;

type    
    // return nonzero means abort operation in progress
    TICStatusProc               = function(lParam: LPARAM; message: UINT; l: DWORD): DWORD; stdcall;

    PICSETSTATUSPROC            = ^TICSETSTATUSPROC;
    TICSETSTATUSPROC            = record
        dwFlags                 : DWORD ;
        lParam                  : LPARAM ;
        Status                  : TICStatusProc;
    end;

{-----------------------------------------------------------------------------}

const
    ICDECOMPRESS_HURRYUP        = $80000000 ;   // don't draw just buffer (hurry up!)
    ICDECOMPRESS_UPDATE         = $40000000 ;   // don't draw just update screen
    ICDECOMPRESS_PREROLL        = $20000000 ;   // this frame is before real start
    ICDECOMPRESS_NULLFRAME      = $10000000 ;   // repeat last frame
    ICDECOMPRESS_NOTKEYFRAME    = $08000000 ;   // this frame is not a key frame

type
    PICDECOMPRESS               = ^TICDECOMPRESS;
    TICDECOMPRESS               = record
        dwFlags                 : DWORD ;               // flags (from AVI index...)
        lpbiInput               : PBITMAPINFOHEADER ;   // BITMAPINFO of compressed data
                                                        // biSizeImage has the chunk size
        lpInput                 : Pointer ;               // compressed data
        lpbiOutput              : PBITMAPINFOHEADER ;   // DIB to decompress to
        lpOutput                : Pointer ;
        ckid                    : DWORD ;               // ckid from AVI file
    end;

    PICDECOMPRESSEX             = ^TICDECOMPRESSEX;
    TICDECOMPRESSEX             = record

        //
        // same as ICM_DECOMPRESS
        //

        dwFlags                 : DWORD;
        lpbiSrc                 : PBITMAPINFOHEADER;    // BITMAPINFO of compressed data
        lpSrc                   : Pointer;                // compressed data
        lpbiDst                 : PBITMAPINFOHEADER;    // DIB to decompress to
        lpDst                   : Pointer;                // output data

        //
        // new for ICM_DECOMPRESSEX
        //

        xDst                    : integer ; // destination rectangle
        yDst                    : integer ;
        dxDst                   : integer ;
        dyDst                   : integer ;

        xSrc                    : integer ; // source rectangle
        ySrc                    : integer ;
        dxSrc                   : integer ;
        dySrc                   : integer ;
    end;

{-----------------------------------------------------------------------------}

const
    ICDRAW_QUERY                = $00000001 ; // test for support
    ICDRAW_FULLSCREEN           = $00000002 ; // draw to full screen
    ICDRAW_HDC                  = $00000004 ; // draw to a HDC/HWND
    ICDRAW_ANIMATE              = $00000008 ;   // expect palette animation
    ICDRAW_CONTINUE             = $00000010 ;   // draw is a continuation of previous draw
    ICDRAW_MEMORYDC             = $00000020 ;   // DC is offscreen, by the way
    ICDRAW_UPDATING             = $00000040 ;   // We're updating, as opposed to playing
    ICDRAW_RENDER               = $00000080 ; // used to render data not draw it
    ICDRAW_BUFFER               = $00000100 ; // please buffer this data offscreen, we will need to update it

type
    PICDRAWBEGIN                = ^TICDRAWBEGIN;
    TICDRAWBEGIN                = record
        dwFlags                 : DWORD ;       // flags

        hpal                    : HPALETTE ;    // palette to draw with
        hwnd                    : HWND ;        // window to draw to
        hdc                     : HDC ;         // HDC to draw to

        xDst                    : integer ;         // destination rectangle
        yDst                    : integer ;
        dxDst                   : integer ;
        dyDst                   : integer ;

        lpbi                    : PBITMAPINFOHEADER ;
                                                // format of frame to draw

        xSrc                    : integer ;         // source rectangle
        ySrc                    : integer ;
        dxSrc                   : integer ;
        dySrc                   : integer ;

        dwRate                  : DWORD ;       // frames/second = (dwRate/dwScale)
        dwScale                 : DWORD ;
    end;

{-----------------------------------------------------------------------------}

const
    ICDRAW_HURRYUP              = $80000000 ;   // don't draw just buffer (hurry up!)
    ICDRAW_UPDATE               = $40000000 ;   // don't draw just update screen
    ICDRAW_PREROLL              = $20000000 ;   // this frame is before real start
    ICDRAW_NULLFRAME            = $10000000 ;   // repeat last frame
    ICDRAW_NOTKEYFRAME          = $08000000 ;   // this frame is not a key frame

type
    PICDRAW                     = ^TICDRAW;
    TICDRAW                     = record
        dwFlags                 : DWORD ;   // flags
        lpFormat                : Pointer ;   // format of frame to decompress
        lpData                  : Pointer ;   // frame data to decompress
        cbData                  : DWORD ;
        lTime                   : DWORD  ;   // time in drawbegin units (see dwRate and dwScale)
    end;

    PICDRAWSUGGEST              = ^TICDRAWSUGGEST;
    TICDRAWSUGGEST              = record
        lpbiIn                  : PBITMAPINFOHEADER ;   // format to be drawn
        lpbiSuggest             : PBITMAPINFOHEADER ;   // location for suggested format (or NULL to get size)
        dxSrc                   : integer ;                 // source extent or 0
        dySrc                   : integer ;
        dxDst                   : integer ;                 // dest extent or 0
        dyDst                   : integer ;
        hicDecompressor         : HIC ;                 // decompressor you can talk to
    end;

{-----------------------------------------------------------------------------}

    PICPALETTE                  = ^TICPALETTE;
    TICPALETTE                  = record
        dwFlags                 : DWORD ;           // flags (from AVI index...)
        iStart                  : integer ;             // first palette to change
        iLen                    : integer ;             // count of entries to change.
        lppe                    : PPALETTEENTRY ;   // palette
    end;

{-- ICM function declarations ------------------------------------------------}

function    ICInfo(fccType, fccHandler: DWORD; lpicinfo: PICINFO) : BOOL ; stdcall ;
function    ICInstall(fccType, fccHandler: DWORD; lParam: LPARAM; szDesc: LPSTR; wFlags: UINT) : BOOL ; stdcall ;
function    ICRemove(fccType, fccHandler: DWORD; wFlags: UINT) : BOOL ; stdcall ;
function    ICGetInfo(hic: HIC; picinfo: PICINFO; cb: DWORD) : DWORD ; stdcall ;

function    ICOpen(fccType, fccHandler: DWORD; wMode: UINT) : HIC ; stdcall ;
function    ICOpenFunction(fccType, fccHandler: DWORD; wMode: UINT; lpfnHandler: TFarProc) : HIC ; stdcall ;
function    ICClose(hic: HIC) : DWORD; stdcall ;

function    ICSendMessage(hic: HIC; msg: UINT; dw1, dw2: integer) : DWORD ; stdcall ;

{-- Values for wFlags of ICInstall -------------------------------------------}

const
    ICINSTALL_UNICODE           = $8000 ;

    ICINSTALL_FUNCTION          = $0001 ; // lParam is a DriverProc (function ptr)
    ICINSTALL_DRIVER            = $0002 ; // lParam is a driver name (string)
    ICINSTALL_HDRV              = $0004 ; // lParam is a HDRVR (driver handle)

    ICINSTALL_DRIVERW           = $8002 ; // lParam is a unicode driver name

{-- Query macros -------------------------------------------------------------}

    ICMF_CONFIGURE_QUERY        = $00000001 ;
    ICMF_ABOUT_QUERY            = $00000001 ;

function    ICQueryAbout(hic: HIC): BOOL;
function    ICAbout(hic: HIC; hwnd: HWND): DWORD;
function    ICQueryConfigure(hic: HIC): BOOL;
function    ICConfigure(hic: HIC; hwnd: HWND): DWORD;

{-- Get/Set state macros -----------------------------------------------------}

function    ICGetState(hic: HIC; pv: Pointer; cb: DWORD): DWORD;
function    ICSetState(hic: HIC; pv: Pointer; cb: DWORD): DWORD;
function    ICGetStateSize(hic: HIC): DWORD;

{-- Get value macros ---------------------------------------------------------}

function    ICGetDefaultQuality(hic: HIC): DWORD;
function    ICGetDefaultKeyFrameRate(hic: HIC): DWORD;

{-- Draw window macro --------------------------------------------------------}

function    ICDrawWindow(hic: HIC; prc: PRECT): DWORD;

{== Compression functions ====================================================}

{-- ICCompress() - compress a single frame -----------------------------------}

function    ICCompress(
    hic             : HIC;
    dwFlags         : DWORD;                // flags
    lpbiOutput      : PBITMAPINFOHEADER;    // output format
    lpData          : Pointer;                // output data
    lpbiInput       : PBITMAPINFOHEADER;    // format of frame to compress
    lpBits          : Pointer;                // frame data to compress
    lpckid          : PDWORD;               // ckid for data in AVI file
    lpdwFlags       : PDWORD;               // flags in the AVI index.
    lFrameNum       : DWORD;                 // frame number of seq.
    dwFrameSize     : DWORD;                // reqested size in bytes. (if non zero)
    dwQuality       : DWORD;                // quality within one frame
    lpbiPrev        : PBITMAPINFOHEADER;    // format of previous frame
    lpPrev          : Pointer                 // previous frame
    ) : DWORD; cdecl;

{-- ICCompressBegin() - start compression from a source fmt to a dest fmt ----}

function    ICCompressBegin(hic: HIC; lpbiInput: PBITMAPINFOHEADER; lpbiOutput: PBITMAPINFOHEADER): DWORD;

{-- ICCompressQuery() - determines if compression from src to dst is supp ----}

function    ICCompressQuery(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;

{-- ICCompressGetFormat() - get the output format (fmt of compressed) --------}

// if lpbiOutput is nil return the size in bytes needed for format.

function    ICCompressGetFormat(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;
function    ICCompressGetFormatSize(hic: HIC; lpbi: PBITMAPINFOHEADER): DWORD;

{-- ICCompressSize() - return the maximal size of a compressed frame ---------}

function    ICCompressGetSize(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;
function    ICCompressEnd(hic: HIC): DWORD;

{== Decompression functions ==================================================}

{-- ICDecompress() - decompress a single frame -------------------------------}

function    ICDecompress(
    hic             : HIC;
    dwFlags         : DWORD;                // flags (from AVI index...)
    lpbiFormat      : PBITMAPINFOHEADER;    // BITMAPINFO of compressed data
                                            // biSizeImage has the chunk size
    lpData          : Pointer;                // data
    lpbi            : PBITMAPINFOHEADER;    // DIB to decompress to
    lpBits          : Pointer
    ): DWORD; cdecl;

{-- ICDecompressBegin() - start compression from src fmt to a dest fmt -------}

function    ICDecompressBegin(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;

{-- ICDecompressQuery() - determines if compression is supported -------------}

function    ICDecompressQuery(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;

{-- ICDecompressGetFormat - get the output fmt (fmt of uncompressed data) ----}

// if lpbiOutput is NULL return the size in bytes needed for format.

function    ICDecompressGetFormat(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;
function    ICDecompressGetFormatSize(hic: HIC; lpbi: PBITMAPINFOHEADER): DWORD;

{-- ICDecompressGetPalette() - get the output palette ------------------------}

function    ICDecompressGetPalette(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;
function    ICDecompressSetPalette(hic: HIC; lpbiPalette: PBITMAPINFOHEADER): DWORD;

function    ICDecompressEnd(hic: HIC): DWORD;

{== Decompression(ex) functions ==============================================}

//
// on Win16 these functions are macros that call ICMessage. ICMessage will
// not work on NT. rather than add new entrypoints we have given
// them as static inline functions
//

{-- ICDecompressEx() - decompress a single frame -----------------------------}

function    ICDecompressEx(
    hic         : HIC;
    dwFlags     : DWORD;
    lpbiSrc     : PBITMAPINFOHEADER;
    lpSrc       : Pointer;
    xSrc        : integer;
    ySrc        : integer;
    dxSrc       : integer;
    dySrc       : integer;
    lpbiDst     : PBITMAPINFOHEADER;
    lpDst       : Pointer;
    xDst        : integer;
    yDst        : integer;
    dxDst       : integer;
    dyDst       : integer
    ): DWORD; stdcall;

{-- ICDecompressExBegin() - start compression from a src fmt to a dest fmt ---}

function    ICDecompressExBegin(
    hic         : HIC;
    dwFlags     : DWORD;
    lpbiSrc     : PBITMAPINFOHEADER;
    lpSrc       : Pointer;
    xSrc        : integer;
    ySrc        : integer;
    dxSrc       : integer;
    dySrc       : integer;
    lpbiDst     : PBITMAPINFOHEADER;
    lpDst       : Pointer;
    xDst        : integer;
    yDst        : integer;
    dxDst       : integer;
    dyDst       : integer
    ): DWORD; stdcall;

{-- ICDecompressExQuery() ----------------------------------------------------}

function    ICDecompressExQuery(
    hic         : HIC;
    dwFlags     : DWORD;
    lpbiSrc     : PBITMAPINFOHEADER;
    lpSrc       : Pointer;
    xSrc        : integer;
    ySrc        : integer;
    dxSrc       : integer;
    dySrc       : integer;
    lpbiDst     : PBITMAPINFOHEADER;
    lpDst       : Pointer;
    xDst        : integer;
    yDst        : integer;
    dxDst       : integer;
    dyDst       : integer
    ): DWORD; stdcall;

function    ICDecompressExEnd(hic: HIC): DWORD;

{== Drawing functions ========================================================}

{-- ICDrawBegin() - start decompressing data with fmt directly to screen -----}

// return zero if the decompressor supports drawing.

function    ICDrawBegin(
    hic         : HIC;
    dwFlags     : DWORD;                // flags
    hpal        : HPALETTE;             // palette to draw with
    hwnd        : HWND;                 // window to draw to
    hdc         : HDC;                  // HDC to draw to
    xDst        : integer;                  // destination rectangle
    yDst        : integer;
    dxDst       : integer;
    dyDst       : integer;
    lpbi        : PBITMAPINFOHEADER;    // format of frame to draw
    xSrc        : integer;                  // source rectangle
    ySrc        : integer;
    dxSrc       : integer;
    dySrc       : integer;
    dwRate      : DWORD;                // frames/second = (dwRate/dwScale)
    dwScale     : DWORD
    ): DWORD; cdecl;

{-- ICDraw() - decompress data directly to the screen ------------------------}

function    ICDraw(
    hic         : HIC;
    dwFlags     : DWORD;                // flags
    lpFormat    : Pointer;                // format of frame to decompress
    lpData      : Pointer;                // frame data to decompress
    cbData      : DWORD;                // size of data
    lTime       : DWORD                  // time to draw this frame
    ): DWORD; cdecl;

// ICMessage is not supported on Win32, so provide a static inline function
// to do the same job

function    ICDrawSuggestFormat(
    hic         : HIC;
    lpbiIn      : PBITMAPINFOHEADER;
    lpbiOut     : PBITMAPINFOHEADER;
    dxSrc       : integer;
    dySrc       : integer;
    dxDst       : integer;
    dyDst       : integer;
    hicDecomp   : HIC
    ): DWORD; stdcall;

{-- ICDrawQuery() - determines if the compressor is willing to render fmt ----}

function    ICDrawQuery(hic: HIC; lpbiInput: PBITMAPINFOHEADER): DWORD;
function    ICDrawChangePalette(hic: HIC; lpbiInput: PBITMAPINFOHEADER): DWORD;
function    ICGetBuffersWanted(hic: HIC; lpdwBuffers: PDWORD): DWORD;
function    ICDrawEnd(hic: HIC): DWORD;
function    ICDrawStart(hic: HIC): DWORD;
function    ICDrawStartPlay(hic: HIC; lFrom, lTo: DWORD): DWORD;
function    ICDrawStop(hic: HIC): DWORD;
function    ICDrawStopPlay(hic: HIC): DWORD;
function    ICDrawGetTime(hic: HIC; lplTime: PDWORD): DWORD;
function    ICDrawSetTime(hic: HIC; lTime: DWORD): DWORD;
function    ICDrawRealize(hic: HIC; hdc: HDC; fBackground: BOOL): DWORD;
function    ICDrawFlush(hic: HIC): DWORD;
function    ICDrawRenderBuffer(hic: HIC): DWORD;

{== Status callback functions ================================================}

{-- ICSetStatusProc() - Set the status callback function ---------------------}

// ICMessage is not supported on NT

function    ICSetStatusProc(
    hic         : HIC;
    dwFlags     : DWORD;
    lParam      : DWORD;
    fpfnStatus  : TICStatusProc
    ): DWORD; stdcall;

{== Helper routines for DrawDib and MCIAVI... ================================}

function    ICLocate(fccType, fccHandler: DWORD; lpbiIn, lpbiOut: PBITMAPINFOHEADER; wFlags: WORD): HIC; stdcall;
function    ICGetDisplayFormat(hic: HIC; lpbiIn, lpbiOut: PBITMAPINFOHEADER; BitDepth: integer; dx, dy: integer): HIC; stdcall;

function    ICDecompressOpen(fccType, fccHandler: DWORD; lpbiIn, lpbiOut: PBITMAPINFOHEADER): HIC;
function    ICDrawOpen(fccType, fccHandler: DWORD; lpbiIn: PBITMAPINFOHEADER): HIC;

{== Higher level functions ===================================================}

function    ICImageCompress(
    hic         : HIC;                  // compressor to use
    uiFlags     : UINT;                 // flags (none yet)
    lpbiIn      : PBITMAPINFO;          // format to compress from
    lpBits      : Pointer;                // data to compress
    lpbiOut     : PBITMAPINFO;          // compress to this (NULL ==> default)
    lQuality    : DWORD;                 // quality to use
    plSize      : PDWORD                 // compress to this size (0=whatever)
    ): THANDLE; stdcall;

function    ICImageDecompress(
    hic         : HIC;                  // compressor to use
    uiFlags     : UINT;                 // flags (none yet)
    lpbiIn      : PBITMAPINFO;          // format to decompress from
    lpBits      : Pointer;                // data to decompress
    lpbiOut     : PBITMAPINFO           // decompress to this (NULL ==> default)
    ): THANDLE; stdcall;

{-- TCompVars ----------------------------------------------------------------}
    
//
// Structure used by ICSeqCompressFrame and ICCompressorChoose routines
// Make sure this matches the autodoc in icm.c!
//

type
    PCOMPVARS       = ^TCOMPVARS;
    TCOMPVARS       = record
        cbSize      : DWORD;             // set to sizeof(COMPVARS) before
                                        // calling ICCompressorChoose
        dwFlags     : DWORD;            // see below...
        hic         : HIC;              // HIC of chosen compressor
        fccType     : DWORD;            // basically ICTYPE_VIDEO
        fccHandler  : DWORD;            // handler of chosen compressor or
                                        // "" or "DIB "
        lpbiIn      : PBITMAPINFO;      // input format
        lpbiOut     : PBITMAPINFO;      // output format - will compress to this
        lpBitsOut   : Pointer;
        lpBitsPrev  : Pointer;
        lFrame      : DWORD;
        lKey        : DWORD;             // key frames how often?
        lDataRate   : DWORD;             // desired data rate KB/Sec
        lQ          : DWORD;             // desired quality
        lKeyCount   : DWORD;
        lpState     : Pointer;            // state of compressor
        cbState     : DWORD;             // size of the state
    end;

// FLAGS for dwFlags element of COMPVARS structure:
// set this flag if you initialize COMPVARS before calling ICCompressorChoose

const
    ICMF_COMPVARS_VALID         = $00000001;    // COMPVARS contains valid data

{-- ICCompressorChoose() - allows user to choose compressor, quality etc... --}

function    ICCompressorChoose(
    hwnd        : HWND;                     // parent window for dialog
    uiFlags     : UINT;                     // flags
    pvIn        : Pointer;                    // input format (optional)
    lpData      : Pointer;                    // input data (optional)
    pc          : PCOMPVARS;                // data about the compressor/dlg
    lpszTitle   : LPSTR                     // dialog title (optional)
    ): BOOL; stdcall;

// defines for uiFlags

const
    ICMF_CHOOSE_KEYFRAME        = $0001;    // show KeyFrame Every box
    ICMF_CHOOSE_DATARATE        = $0002;    // show DataRate box
    ICMF_CHOOSE_PREVIEW         = $0004;    // allow expanded preview dialog
    ICMF_CHOOSE_ALLCOMPRESSORS  = $0008;    // don't only show those that
                                            // can handle the input format
                                            // or input data

function    ICSeqCompressFrameStart(pc: PCOMPVARS; lpbiIn: PBITMAPINFO): BOOL; stdcall;
procedure   ICSeqCompressFrameEnd(pc: PCOMPVARS); stdcall;

function    ICSeqCompressFrame(
    pc          : PCOMPVARS;                // set by ICCompressorChoose
    uiFlags     : UINT;                     // flags
    lpBits      : Pointer;                    // input DIB bits
    pfKey       : PBOOL;                    // did it end up being a key frame?
    plSize      : PDWORD                     // size to compress to/of returned image
    ): Pointer; stdcall;

procedure   ICCompressorFree(pc: PCOMPVARS); stdcall;























implementation

// Dlls

const
  AVICAP32      = 'AVICAP32.dll';
  VFWDLL        = 'MSVFW32.DLL';




(* Externals from AVICAP.DLL *)
function capGetDriverDescription; external AVICAP32 name 'capGetDriverDescriptionA';
function capCreateCaptureWindow;  external AVICAP32 name 'capCreateCaptureWindowA';


(* Message crackers for above *)
function capSetCallbackOnError(hwnd : THandle; fpProc:TCAPERRORCALLBACK) : LongInt;
begin
	Result := SendMessage(hwnd, WM_CAP_SET_CALLBACK_ERROR, 0,LPARAM(@fpProc));
end;

function capSetCallbackOnStatus(hwnd : THandle; fpProc:TCAPSTATUSCALLBACK):LongInt;
begin
	Result := SendMessage(hwnd, WM_CAP_SET_CALLBACK_STATUS, 0, LPARAM(@fpProc));
end;

function capSetCallbackOnYield (hwnd : THandle; fpProc:TCAPYIELDCALLBACK):LongInt;
begin
	Result := SendMessage(hwnd, WM_CAP_SET_CALLBACK_YIELD, 0, LPARAM(@fpProc));
end;

function capSetCallbackOnFrame (hwnd : THandle; fpProc:TCAPVIDEOSTREAMCALLBACK):LongInt;
begin
	Result := SendMessage(hwnd, WM_CAP_SET_CALLBACK_FRAME, 0,LPARAM( @fpProc));
end;

function capSetCallbackOnVideoStream(hwnd:THandle; fpProc:TCAPVIDEOSTREAMCALLBACK):LongInt;
begin
	Result := SendMessage(hwnd, WM_CAP_SET_CALLBACK_VIDEOSTREAM, 0, LPARAM(@fpProc));
end;

function capSetCallbackOnWaveStream (hwnd:THandle; fpProc:TCAPWAVESTREAMCALLBACK):LongInt;
begin
	Result := SendMessage(hwnd, WM_CAP_SET_CALLBACK_WAVESTREAM, 0, LPARAM(@fpProc));
end;

function capSetCallbackOnCapControl (hwnd:THandle; fpProc:TCAPCONTROLCALLBACK):longint;
begin
	Result := SendMessage(hwnd, WM_CAP_SET_CALLBACK_CAPCONTROL, 0, LPARAM(@fpProc));
end;

function capSetUserData(hwnd:THandle; lUser:LongInt):LongInt;
begin
	Result := SendMessage(hwnd, WM_CAP_SET_USER_DATA, 0, lUser);
end;

function capGetUserData(hwnd:THandle):LongInt;
begin
	Result := SendMessage(hwnd, WM_CAP_GET_USER_DATA, 0, 0);
end;

function capDriverConnect(hwnd:THandle; I: Word) : boolean;
begin
	Result :=boolean( SendMessage(hwnd, WM_CAP_DRIVER_CONNECT, WPARAM(I), 0));
end;

function capDriverDisconnect(hwnd:THandle):Boolean;
begin
	Result := boolean(SendMessage(hwnd, WM_CAP_DRIVER_DISCONNECT, 0, 0));
end;

function capDriverGetName(hwnd:THandle; szName:PChar; wSize:Word):boolean;
begin
	Result :=boolean( SendMessage(hwnd, WM_CAP_DRIVER_GET_NAME, WPARAM(wSize), LPARAM( szName)));
end;

function capDriverGetVersion(hwnd:THandle; szVer:PChar; wSize:Word):boolean;
begin
	Result :=boolean( SendMessage(hwnd, WM_CAP_DRIVER_GET_VERSION, WPARAM(wSize),LPARAM( szVer)));
end;

function capDriverGetCaps(hwnd:THandle; s:pCapDriverCaps; wSize:Word):boolean;
begin
	Result := boolean(SendMessage(hwnd, WM_CAP_DRIVER_GET_CAPS, WPARAM(wSize),LPARAM(s)));
end;

function capFileSetCaptureFile(hwnd:THandle; szName:PChar):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_FILE_SET_CAPTURE_FILE, 0, LPARAM(szName)));
end;

function capFileGetCaptureFile(hwnd:THandle; szName:PChar; wSize:Word):Boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_FILE_GET_CAPTURE_FILE, wSize, LPARAM(szName)));
end;

function capFileAlloc(hwnd:THandle; dwSize:DWord):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_FILE_ALLOCATE, 0, LPARAM(dwSize)));
end;

function capFileSaveAs(hwnd:THandle; szName:Pchar):Boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_FILE_SAVEAS, 0,LPARAM(szName)));
end;

function capFileSetInfoChunk(hwnd:THandle; lpInfoChunk:pCapInfoChunk):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_FILE_SET_INFOCHUNK, 0, LPARAM(lpInfoChunk)));
end;

function capFileSaveDIB(hwnd:THandle; szName:Pchar):Boolean;
begin
	Result :=Boolean(SendMessage(hwnd, WM_CAP_FILE_SAVEDIB, 0,LPARAM(szName)));
end;

function capEditCopy(hwnd : THandle):Boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_EDIT_COPY, 0, 0));
end;

function capSetAudioFormat(hwnd:THandle; s:PWaveFormatEx; wSize:Word):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_SET_AUDIOFORMAT, WPARAM(wSize),LPARAM(s)));
end;

function capGetAudioFormat(hwnd:THandle; s:PWaveFormatEx; wSize:Word):DWORD;
begin
	Result :=DWORD( SendMessage(hwnd, WM_CAP_GET_AUDIOFORMAT, WPARAM(wSize),LPARAM(s)));
end;

function capGetAudioFormatSize(hwnd:THandle):DWORD;
begin
	Result := DWORD(SendMessage(hwnd, WM_CAP_GET_AUDIOFORMAT, 0, 0));
end;

function capDlgVideoFormat(hwnd:THandle):boolean;
begin
	Result :=boolean(SendMessage(hwnd, WM_CAP_DLG_VIDEOFORMAT, 0, 0));
end;

function capDlgVideoSource(hwnd:THandle):boolean;
begin
	Result :=boolean (SendMessage(hwnd, WM_CAP_DLG_VIDEOSOURCE, 0, 0));
end;

function capDlgVideoDisplay(hwnd:THandle):boolean;
begin
	Result := boolean(SendMessage(hwnd, WM_CAP_DLG_VIDEODISPLAY, 0, 0));
end;

function capDlgVideoCompression(hwnd:THandle):boolean;
begin
	Result := boolean(SendMessage(hwnd, WM_CAP_DLG_VIDEOCOMPRESSION, 0, 0));
end;

function capGetVideoFormat(hwnd:THandle; s:pBitmapInfo; wSize:Word):DWord;
begin
	Result := DWord(SendMessage(hwnd, WM_CAP_GET_VIDEOFORMAT, Wparam(wSize), LPARAM(s)));
end;

function capGetVideoFormatSize(hwnd:THandle):DWord;
begin
	Result := DWord(SendMessage(hwnd, WM_CAP_GET_VIDEOFORMAT, 0, 0));
end;

function capSetVideoFormat(hwnd:THandle; s:PBitmapInfo; wSize:Word):Boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_SET_VIDEOFORMAT, WPARAM(wSize), LPARAM(s)));
end;

function capPreview(hwnd:THandle; f:boolean):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_SET_PREVIEW, WPARAM(f), 0));
end;

function capPreviewRate(hwnd:THandle; wMS:Word):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_SET_PREVIEWRATE, WPARAM(wMS), 0));
end;

function capOverlay(hwnd:THandle; f:boolean):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_SET_OVERLAY, WPARAM(f), 0));
end;

function capPreviewScale(hwnd:THandle; f:boolean):Boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_SET_SCALE,WPARAM(f), 0));
end;

function capGetStatus(hwnd:THandle; s:PCapStatus; wSize:Word):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_GET_STATUS, WPARAM(wSize),LPARAM(s)));
end;

function capSetScrollPos(hwnd:THandle; lpP:pPoint):Boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_SET_SCROLL, 0, LParam(lpP)));
end;

function capGrabFrame(hwnd:THandle):boolean;
begin
     Result := Boolean(SendMessage(hwnd, WM_CAP_GRAB_FRAME, 0, 0));
end;

function capGrabFrameNoStop(hwnd:THandle):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_GRAB_FRAME_NOSTOP, 0, 0));
end;

function capCaptureSequence(hwnd:THandle):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_SEQUENCE, 0, 0));
end;

function capCaptureSequenceNoFile(hwnd:THandle):boolean;
begin
	Result :=Boolean(SendMessage(hwnd, WM_CAP_SEQUENCE_NOFILE, 0, 0));
end;

function capCaptureStop(hwnd:THandle):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_STOP, 0, 0));
end;

function capCaptureAbort(hwnd:THandle):Boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_ABORT, 0, 0));
end;

function capCaptureSingleFrameOpen(hwnd:THandle):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_SINGLE_FRAME_OPEN, 0, 0));
end;

function capCaptureSingleFrameClose(hwnd:THandle):boolean ;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_SINGLE_FRAME_CLOSE, 0, 0));
end;

function capCaptureSingleFrame(hwnd:THandle):boolean;
begin
	Result :=Boolean(SendMessage(hwnd, WM_CAP_SINGLE_FRAME, 0, 0));
end;

function capCaptureGetSetup(hwnd:THandle; s:pCaptureParms; wSize:Word):boolean;
begin
	Result :=Boolean( SendMessage(hwnd, WM_CAP_GET_SEQUENCE_SETUP, WPARAM(wSize),LPARAM(s)));
end;

function capCaptureSetSetup(hwnd:THandle; s:pCaptureParms; wSize:Word):boolean;
begin
	Result := Boolean (SendMessage(hwnd, WM_CAP_SET_SEQUENCE_SETUP, WParam(wSize),LParam(s)));
end;

function capSetMCIDeviceName(hwnd:THandle; szName:Pchar):Boolean;
begin
	Result :=Boolean( SendMessage(hwnd, WM_CAP_SET_MCI_DEVICE, 0, LParam(szName)));
end;

function capGetMCIDeviceName(hwnd:THandle; szName:Pchar; wSize:Word):Boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_GET_MCI_DEVICE, Wparam(wSize), LPARAM(szName)));
end;

function capPaletteOpen(hwnd:THandle; szName:PChar):Boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_PAL_OPEN, 0, LParam(szName)));
end;

function capPaletteSave(hwnd:THandle; szName:PChar):boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_PAL_SAVE, 0,LParam(szName)));
end;

function capPalettePaste(hwnd:THandle):Boolean;
begin
	Result :=Boolean( SendMessage(hwnd, WM_CAP_PAL_PASTE, 0, 0));
end;

function capPaletteAuto(hwnd:THandle; iFrames:Word; iColors:word):Boolean;
begin
	Result :=Boolean( SendMessage(hwnd, WM_CAP_PAL_AUTOCREATE, WPARAM(iFrames),LPARAM(iColors)));
end;

function capPaletteManual(hwnd:THandle; fGrab:Word; iColors:word):Boolean;
begin
	Result := Boolean(SendMessage(hwnd, WM_CAP_PAL_MANUALCREATE, WPARAM(fGrab),LPARAM(iColors)));
end;


{== DrawDib functions ========================================================}

{-- DrawDibOpen() ------------------------------------------------------------}

function    DrawDibOpen: HDRAWDIB; stdcall; external VFWDLL;

{-- DrawDibClose() -----------------------------------------------------------}

function    DrawDibClose(hdd: HDRAWDIB): BOOL; stdcall; external VFWDLL;

{-- DrawDibGetBuffer() -------------------------------------------------------}

function    DrawDibGetBuffer(hdd: HDRAWDIB; lpbi: PBITMAPINFOHEADER; dwSize: DWORD; dwFlags: DWORD): Pointer; stdcall; external VFWDLL;

{-- DrawDibGetPalette() - get the palette used for drawing DIBs --------------}

function    DrawDibGetPalette(hdd: HDRAWDIB): HPALETTE; stdcall; external VFWDLL;

{-- DrawDibSetPalette() - set the palette used for drawing DIBs --------------}

function    DrawDibSetPalette(hdd: HDRAWDIB; hpal: HPALETTE): BOOL; stdcall; external VFWDLL;

{-- DrawDibChangePalette() ---------------------------------------------------}

function    DrawDibChangePalette(hdd: HDRAWDIB; iStart, iLen: integer; lppe: PPALETTEENTRY): BOOL; stdcall; external VFWDLL;

{-- DrawDibRealize() - realize the palette in a HDD --------------------------}

function    DrawDibRealize(hdd: HDRAWDIB; hdc: HDC; fBackground: BOOL): UINT; stdcall; external VFWDLL;

{-- DrawDibStart() - start of streaming playback -----------------------------}

function    DrawDibStart(hdd: HDRAWDIB; rate: DWORD): BOOL; stdcall; external VFWDLL;

{-- DrawDibStop() - start of streaming playback ------------------------------}

function    DrawDibStop(hdd: HDRAWDIB): BOOL; stdcall; external VFWDLL;

{-- DrawDibBegin() - prepare to draw -----------------------------------------}

function    DrawDibBegin(
    hdd         : HDRAWDIB;
    hdc         : HDC;
    dxDst       : integer;
    dyDst       : integer;
    lpbi        : PBITMAPINFOHEADER;
    dxSrc       : integer;
    dySrc       : integer;
    wFlags      : UINT
    ): BOOL; stdcall; external VFWDLL;

{-- DrawDibDraw() - actually draw a DIB to the screen ------------------------}

function    DrawDibDraw(
    hdd         : HDRAWDIB;
    hdc         : HDC;
    xDst        : integer;
    yDst        : integer;
    dxDst       : integer;
    dyDst       : integer;
    lpbi        : PBITMAPINFOHEADER;
    lpBits      : Pointer;
    xSrc        : integer;
    ySrc        : integer;
    dxSrc       : integer;
    dySrc       : integer;
    wFlags      : UINT
    ): BOOL; stdcall; external VFWDLL;

{-- DrawDibEnd() -------------------------------------------------------------}

function    DrawDibEnd(hdd: HDRAWDIB): BOOL; stdcall; external VFWDLL;

{-- DrawDibTime() - for debugging purposes only ------------------------------}

function    DrawDibTime(hdd: HDRAWDIB; lpddtime: PDRAWDIBTIME): BOOL; stdcall; external VFWDLL;

{-- Display profiling --------------------------------------------------------}

function    DrawDibProfileDisplay(lpbi: PBITMAPINFOHEADER): DWORD; stdcall; external VFWDLL;




// Installable Compression Manager

function    MKFOURCC( ch0, ch1, ch2, ch3: Char ): FOURCC;
begin
    Result := (DWord(Ord(ch0))) or
              (DWord(Ord(ch1)) shl 8) or
              (DWord(Ord(ch2)) shl 16) or
              (DWord(Ord(ch3)) shl 24);
end;

function    mmioFOURCC( ch0, ch1, ch2, ch3: Char ): FOURCC;
begin
    Result := MKFOURCC(ch0,ch1,ch2,ch3);
end;

function    aviTWOCC(ch0, ch1: Char): TWOCC;
begin
    Result := (Word(Ord(ch0))) or
              (Word(Ord(ch1)) shl 8);
end;

{-- Query macros -------------------------------------------------------------}

function    ICQueryAbout(hic: HIC): BOOL;
begin
    Result := ICSendMessage(hic, ICM_ABOUT, -1, ICMF_ABOUT_QUERY) = ICERR_OK;
end;

function    ICAbout(hic: HIC; hwnd: HWND): DWORD;
begin
    Result := ICSendMessage(hic, ICM_ABOUT, hwnd, 0);
end;

function    ICQueryConfigure(hic: HIC): BOOL;
begin
    Result := ICSendMessage(hic, ICM_CONFIGURE, -1, ICMF_CONFIGURE_QUERY) = ICERR_OK;
end;

function    ICConfigure(hic: HIC; hwnd: HWND): DWORD;
begin
    Result := ICSendMessage(hic, ICM_CONFIGURE, hwnd, 0);
end;

{-- Get/Set state macros -----------------------------------------------------}

function    ICGetState(hic: HIC; pv: Pointer; cb: DWORD): DWORD;
begin
    Result := ICSendMessage(hic, ICM_GETSTATE, DWORD(pv), cb);
end;

function    ICSetState(hic: HIC; pv: Pointer; cb: DWORD): DWORD;
begin
    Result := ICSendMessage(hic, ICM_SETSTATE, DWORD(pv), cb);
end;

function    ICGetStateSize(hic: HIC): DWORD;
begin
    Result := ICGetState(hic, nil, 0);
end;

{-- Get value macros ---------------------------------------------------------}

function    ICGetDefaultQuality(hic: HIC): DWORD;
begin
    ICSendMessage(hic, ICM_GETDEFAULTQUALITY, DWORD(@Result), sizeof(Result));
end;

function    ICGetDefaultKeyFrameRate(hic: HIC): DWORD;
begin
    ICSendMessage(hic, ICM_GETDEFAULTKEYFRAMERATE, DWORD(@Result), sizeof(Result));
end;

{-- Draw window macro --------------------------------------------------------}

function    ICDrawWindow(hic: HIC; prc: PRECT): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_WINDOW, DWORD(prc), sizeof(prc^));
end;

{-- ICCompressBegin() - start compression from a source fmt to a dest fmt ----}

function    ICCompressBegin(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICSendMessage(hic, ICM_COMPRESS_BEGIN, DWORD(lpbiInput), DWORD(lpbiOutput));
end;

{-- ICCompressQuery() - determines if compression from src to dst is supp ----}

function    ICCompressQuery(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICSendMessage(hic, ICM_COMPRESS_QUERY, DWORD(lpbiInput), DWORD(lpbiOutput));
end;

{-- ICCompressGetFormat() - get the output format (fmt of compressed) --------}

// if lpbiOutput is nil return the size in bytes needed for format.

function    ICCompressGetFormat(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICSendMessage(hic, ICM_COMPRESS_GET_FORMAT, DWORD(lpbiInput), DWORD(lpbiOutput));
end;

function    ICCompressGetFormatSize(hic: HIC; lpbi: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICCompressGetFormat(hic, lpbi, nil);
end;

{-- ICCompressSize() - return the maximal size of a compressed frame ---------}

function    ICCompressGetSize(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICSendMessage(hic, ICM_COMPRESS_GET_SIZE, DWORD(lpbiInput), DWORD(lpbiOutput));
end;

function    ICCompressEnd(hic: HIC): DWORD;
begin
    Result := ICSendMessage(hic, ICM_COMPRESS_END, 0, 0);
end;

{-- ICDecompressBegin() - start compression from src fmt to a dest fmt -------}

function    ICDecompressBegin(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DECOMPRESS_BEGIN, DWORD(lpbiInput), DWORD(lpbiOutput));
end;

{-- ICDecompressQuery() - determines if compression is supported -------------}

function    ICDecompressQuery(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DECOMPRESS_QUERY, DWORD(lpbiInput), DWORD(lpbiOutput));
end;

{-- ICDecompressGetFormat - get the output fmt (fmt of uncompressed data) ----}

// if lpbiOutput is NULL return the size in bytes needed for format.

function    ICDecompressGetFormat(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DECOMPRESS_GET_FORMAT, DWORD(lpbiInput), DWORD(lpbiOutput));
end;

function    ICDecompressGetFormatSize(hic: HIC; lpbi: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICDecompressGetFormat(hic, lpbi, nil);
end;

{-- ICDecompressGetPalette() - get the output palette ------------------------}

function    ICDecompressGetPalette(hic: HIC; lpbiInput, lpbiOutput: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DECOMPRESS_GET_PALETTE, DWORD(lpbiInput), DWORD(lpbiOutput));
end;

function    ICDecompressSetPalette(hic: HIC; lpbiPalette: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DECOMPRESS_SET_PALETTE, DWORD(lpbiPalette), 0);
end;

function    ICDecompressEnd(hic: HIC): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DECOMPRESS_END, 0, 0);
end;

{-- ICM function declarations ------------------------------------------------}

function    ICInfo(fccType, fccHandler: DWORD; lpicinfo: PICINFO) : BOOL ; stdcall ; external VFWDLL;
function    ICInstall(fccType, fccHandler: DWORD; lParam: LPARAM; szDesc: LPSTR; wFlags: UINT) : BOOL ; stdcall ; external VFWDLL;
function    ICRemove(fccType, fccHandler: DWORD; wFlags: UINT) : BOOL ; stdcall ; external VFWDLL;
function    ICGetInfo(hic: HIC; picinfo: PICINFO; cb: DWORD) : DWORD ; stdcall ; external VFWDLL;

function    ICOpen(fccType, fccHandler: DWORD; wMode: UINT) : HIC ; stdcall ; external VFWDLL;
function    ICOpenFunction(fccType, fccHandler: DWORD; wMode: UINT; lpfnHandler: TFarProc) : HIC ; stdcall ; external VFWDLL;
function    ICClose(hic: HIC) : DWORD ; stdcall ; external VFWDLL;

function    ICSendMessage(hic: HIC; msg: UINT; dw1, dw2: integer) : DWORD ; stdcall ; external VFWDLL;

{== Compression functions ====================================================}

{-- ICCompress() - compress a single frame -----------------------------------}

function    ICCompress(
    hic             : HIC;
    dwFlags         : DWORD;                // flags
    lpbiOutput      : PBITMAPINFOHEADER;    // output format
    lpData          : Pointer;                // output data
    lpbiInput       : PBITMAPINFOHEADER;    // format of frame to compress
    lpBits          : Pointer;                // frame data to compress
    lpckid          : PDWORD;               // ckid for data in AVI file
    lpdwFlags       : PDWORD;               // flags in the AVI index.
    lFrameNum       : DWORD;                 // frame number of seq.
    dwFrameSize     : DWORD;                // reqested size in bytes. (if non zero)
    dwQuality       : DWORD;                // quality within one frame
    lpbiPrev        : PBITMAPINFOHEADER;    // format of previous frame
    lpPrev          : Pointer                 // previous frame
    ) : DWORD; cdecl; external VFWDLL;

{== Decompression functions ==================================================}

{-- ICDecompress() - decompress a single frame -------------------------------}

function    ICDecompress(
    hic             : HIC;
    dwFlags         : DWORD;                // flags (from AVI index...)
    lpbiFormat      : PBITMAPINFOHEADER;    // BITMAPINFO of compressed data
                                            // biSizeImage has the chunk size
    lpData          : Pointer;                // data
    lpbi            : PBITMAPINFOHEADER;    // DIB to decompress to
    lpBits          : Pointer
    ): DWORD; cdecl; external VFWDLL;

{== Drawing functions ========================================================}

{-- ICDrawBegin() - start decompressing data with fmt directly to screen -----}

// return zero if the decompressor supports drawing.

function    ICDrawBegin(
    hic         : HIC;
    dwFlags     : DWORD;                // flags
    hpal        : HPALETTE;             // palette to draw with
    hwnd        : HWND;                 // window to draw to
    hdc         : HDC;                  // HDC to draw to
    xDst        : integer;                  // destination rectangle
    yDst        : integer;
    dxDst       : integer;
    dyDst       : integer;
    lpbi        : PBITMAPINFOHEADER;    // format of frame to draw
    xSrc        : integer;                  // source rectangle
    ySrc        : integer;
    dxSrc       : integer;
    dySrc       : integer;
    dwRate      : DWORD;                // frames/second = (dwRate/dwScale)
    dwScale     : DWORD
    ): DWORD; cdecl; external VFWDLL;

{-- ICDraw() - decompress data directly to the screen ------------------------}

function    ICDraw(
    hic         : HIC;
    dwFlags     : DWORD;                // flags
    lpFormat    : Pointer;                // format of frame to decompress
    lpData      : Pointer;                // frame data to decompress
    cbData      : DWORD;                // size of data
    lTime       : DWORD                  // time to draw this frame
    ): DWORD; cdecl; external VFWDLL;

{== Helper routines for DrawDib and MCIAVI... ================================}

function    ICLocate(fccType, fccHandler: DWORD; lpbiIn, lpbiOut: PBITMAPINFOHEADER; wFlags: WORD): HIC; stdcall; external VFWDLL;
function    ICGetDisplayFormat(hic: HIC; lpbiIn, lpbiOut: PBITMAPINFOHEADER; BitDepth: integer; dx, dy: integer): HIC; stdcall; external VFWDLL;

{== Higher level functions ===================================================}

function    ICImageCompress(
    hic         : HIC;                  // compressor to use
    uiFlags     : UINT;                 // flags (none yet)
    lpbiIn      : PBITMAPINFO;          // format to compress from
    lpBits      : Pointer;                // data to compress
    lpbiOut     : PBITMAPINFO;          // compress to this (NULL ==> default)
    lQuality    : DWORD;                 // quality to use
    plSize      : PDWORD                 // compress to this size (0=whatever)
    ): THANDLE; stdcall; external VFWDLL;

function    ICImageDecompress(
    hic         : HIC;                  // compressor to use
    uiFlags     : UINT;                 // flags (none yet)
    lpbiIn      : PBITMAPINFO;          // format to decompress from
    lpBits      : Pointer;                // data to decompress
    lpbiOut     : PBITMAPINFO           // decompress to this (NULL ==> default)
    ): THANDLE; stdcall; external VFWDLL;

{-- ICCompressorChoose() - allows user to choose compressor, quality etc... --}

function    ICCompressorChoose(
    hwnd        : HWND;                     // parent window for dialog
    uiFlags     : UINT;                     // flags
    pvIn        : Pointer;                    // input format (optional)
    lpData      : Pointer;                    // input data (optional)
    pc          : PCOMPVARS;                // data about the compressor/dlg
    lpszTitle   : LPSTR                     // dialog title (optional)
    ): BOOL; stdcall; external VFWDLL;

function    ICSeqCompressFrameStart(pc: PCOMPVARS; lpbiIn: PBITMAPINFO): BOOL; stdcall; external VFWDLL;
procedure   ICSeqCompressFrameEnd(pc: PCOMPVARS); stdcall; external VFWDLL;

function    ICSeqCompressFrame(
    pc          : PCOMPVARS;                // set by ICCompressorChoose
    uiFlags     : UINT;                     // flags
    lpBits      : Pointer;                    // input DIB bits
    pfKey       : PBOOL;                    // did it end up being a key frame?
    plSize      : PDWORD                     // size to compress to/of returned image
    ): Pointer; stdcall; external VFWDLL;

procedure   ICCompressorFree(pc: PCOMPVARS); stdcall; external VFWDLL;

{-- ICDecompressEx() - decompress a single frame -----------------------------}

function    ICDecompressEx(
    hic     : HIC;
    dwFlags : DWORD;
    lpbiSrc : PBITMAPINFOHEADER;
    lpSrc   : Pointer;
    xSrc    : integer;
    ySrc    : integer;
    dxSrc   : integer;
    dySrc   : integer;
    lpbiDst : PBITMAPINFOHEADER;
    lpDst   : Pointer;
    xDst    : integer;
    yDst    : integer;
    dxDst   : integer;
    dyDst   : integer
    ): DWORD; stdcall;
var
    ic : TICDECOMPRESSEX;
begin
    ic.dwFlags  := dwFlags;
    ic.lpbiSrc  := lpbiSrc;
    ic.lpSrc    := lpSrc;
    ic.xSrc     := xSrc;
    ic.ySrc     := ySrc;
    ic.dxSrc    := dxSrc;
    ic.dySrc    := dySrc;
    ic.lpbiDst  := lpbiDst;
    ic.lpDst    := lpDst;
    ic.xDst     := xDst;
    ic.yDst     := yDst;
    ic.dxDst    := dxDst;
    ic.dyDst    := dyDst;

    // note that ICM swaps round the length and pointer
    // length in lparam2, pointer in lparam1
    Result := ICSendMessage(hic, ICM_DECOMPRESSEX, DWORD(@ic), sizeof(ic));
end;

{-- ICDecompressExBegin() - start compression from a src fmt to a dest fmt ---}

function    ICDecompressExBegin(
    hic     : HIC;
    dwFlags : DWORD;
    lpbiSrc : PBITMAPINFOHEADER;
    lpSrc   : Pointer;
    xSrc    : integer;
    ySrc    : integer;
    dxSrc   : integer;
    dySrc   : integer;
    lpbiDst : PBITMAPINFOHEADER;
    lpDst   : Pointer;
    xDst    : integer;
    yDst    : integer;
    dxDst   : integer;
    dyDst   : integer
    ): DWORD; stdcall;
var
    ic : TICDECOMPRESSEX ;
begin
    ic.dwFlags  := dwFlags;
    ic.lpbiSrc  := lpbiSrc;
    ic.lpSrc    := lpSrc;
    ic.xSrc     := xSrc;
    ic.ySrc     := ySrc;
    ic.dxSrc    := dxSrc;
    ic.dySrc    := dySrc;
    ic.lpbiDst  := lpbiDst;
    ic.lpDst    := lpDst;
    ic.xDst     := xDst;
    ic.yDst     := yDst;
    ic.dxDst    := dxDst;
    ic.dyDst    := dyDst;

    // note that ICM swaps round the length and pointer
    // length in lparam2, pointer in lparam1
    Result      := ICSendMessage(hic, ICM_DECOMPRESSEX_BEGIN, DWORD(@ic), sizeof(ic));
end;

{-- ICDecompressExQuery() ----------------------------------------------------}

function    ICDecompressExQuery(
    hic     : HIC;
    dwFlags : DWORD;
    lpbiSrc : PBITMAPINFOHEADER;
    lpSrc   : Pointer;
    xSrc    : integer;
    ySrc    : integer;
    dxSrc   : integer;
    dySrc   : integer;
    lpbiDst : PBITMAPINFOHEADER;
    lpDst   : Pointer;
    xDst    : integer;
    yDst    : integer;
    dxDst   : integer;
    dyDst   : integer
    ): DWORD; stdcall;
var
    ic : TICDECOMPRESSEX;
begin
    ic.dwFlags  := dwFlags;
    ic.lpbiSrc  := lpbiSrc;
    ic.lpSrc    := lpSrc;
    ic.xSrc     := xSrc;
    ic.ySrc     := ySrc;
    ic.dxSrc    := dxSrc;
    ic.dySrc    := dySrc;
    ic.lpbiDst  := lpbiDst;
    ic.lpDst    := lpDst;
    ic.xDst     := xDst;
    ic.yDst     := yDst;
    ic.dxDst    := dxDst;
    ic.dyDst    := dyDst;

    // note that ICM swaps round the length and pointer
    // length in lparam2, pointer in lparam1
    Result      := ICSendMessage(hic, ICM_DECOMPRESSEX_QUERY, DWORD(@ic), sizeof(ic));
end;

function    ICDecompressExEnd(hic: HIC): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DECOMPRESSEX_END, 0, 0)
end;

function    ICDrawSuggestFormat(
    hic         : HIC;
    lpbiIn      : PBITMAPINFOHEADER;
    lpbiOut     : PBITMAPINFOHEADER;
    dxSrc       : integer;
    dySrc       : integer;
    dxDst       : integer;
    dyDst       : integer;
    hicDecomp   : HIC
    ): DWORD; stdcall;
var
    ic : TICDRAWSUGGEST;
begin
    ic.lpbiIn           := lpbiIn;
    ic.lpbiSuggest      := lpbiOut;
    ic.dxSrc            := dxSrc;
    ic.dySrc            := dySrc;
    ic.dxDst            := dxDst;
    ic.dyDst            := dyDst;
    ic.hicDecompressor  := hicDecomp;

    // note that ICM swaps round the length and pointer
    // length in lparam2, pointer in lparam1
    Result := ICSendMessage(hic, ICM_DRAW_SUGGESTFORMAT, DWORD(@ic), sizeof(ic));
end;

{-- ICDrawQuery() - determines if the compressor is willing to render fmt ----}

function    ICDrawQuery(hic: HIC; lpbiInput: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_QUERY, DWORD(lpbiInput), 0);
end;

function    ICDrawChangePalette(hic: HIC; lpbiInput: PBITMAPINFOHEADER): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_CHANGEPALETTE, DWORD(lpbiInput), 0);
end;

function    ICGetBuffersWanted(hic: HIC; lpdwBuffers: PDWORD): DWORD;
begin
    Result := ICSendMessage(hic, ICM_GETBUFFERSWANTED, DWORD(lpdwBuffers), 0);
end;

function    ICDrawEnd(hic: HIC): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_END, 0, 0);
end;

function    ICDrawStart(hic: HIC): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_START, 0, 0);
end;

function    ICDrawStartPlay(hic: HIC; lFrom, lTo: DWORD): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_START_PLAY, lFrom, lTo);
end;

function    ICDrawStop(hic: HIC): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_STOP, 0, 0);
end;

function    ICDrawStopPlay(hic: HIC): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_STOP_PLAY, 0, 0);
end;

function    ICDrawGetTime(hic: HIC; lplTime: PDWORD): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_GETTIME, DWORD(lplTime), 0);
end;

function    ICDrawSetTime(hic: HIC; lTime: DWORD): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_SETTIME, lTime, 0);
end;

function    ICDrawRealize(hic: HIC; hdc: HDC; fBackground: BOOL): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_REALIZE, DWORD(hdc), DWORD(fBackground));
end;

function    ICDrawFlush(hic: HIC): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_FLUSH, 0, 0);
end;

function    ICDrawRenderBuffer(hic: HIC): DWORD;
begin
    Result := ICSendMessage(hic, ICM_DRAW_RENDERBUFFER, 0, 0);
end;

{-- ICSetStatusProc() - Set the status callback function ---------------------}

// ICMessage is not supported on NT

function    ICSetStatusProc(
    hic         : HIC;
    dwFlags     : DWORD;
    lParam      : DWORD;
    fpfnStatus  : TICStatusProc
    ): DWORD; stdcall;
var
    ic : TICSETSTATUSPROC;
begin
    ic.dwFlags  := dwFlags;
    ic.lParam   := lParam;
    ic.Status   := fpfnStatus;

    // note that ICM swaps round the length and pointer
    // length in lparam2, pointer in lparam1
    Result      := ICSendMessage(hic, ICM_SET_STATUS_PROC, DWORD(@ic), sizeof(ic));
end;

{== Helper routines for DrawDib and MCIAVI... ================================}

function    ICDecompressOpen(fccType, fccHandler: DWORD; lpbiIn, lpbiOut: PBITMAPINFOHEADER): HIC;
begin
    Result := ICLocate(fccType, fccHandler, lpbiIn, lpbiOut, ICMODE_DECOMPRESS);
end;

function    ICDrawOpen(fccType, fccHandler: DWORD; lpbiIn: PBITMAPINFOHEADER): HIC;
begin
    Result := ICLocate(fccType, fccHandler, lpbiIn, nil, ICMODE_DRAW);
end;


end.


