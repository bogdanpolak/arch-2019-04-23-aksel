unit Plus.Vcl.PageControlFactory;

interface

uses
  System.Classes,
  Vcl.ComCtrls,
  Vcl.Forms;

type
  TPageControlFactory = class (TComponent)
  private
    FPageControl: TPageControl;
    procedure SetPageControl(const aPageControl: TPageControl);
  public
    procedure AddNewFrame<T: TFrame> (const Caption: string);
    property PageControl: TPageControl read FPageControl write SetPageControl;
  end;

implementation

uses
  System.SysUtils,
  Vcl.Controls;

{ TPageControlFactory }

procedure TPageControlFactory.AddNewFrame<T>(const Caption: string);
var
  TabSheet: TTabSheet;
  AFrame: TFrame;
begin
  if FPageControl=nil then
    raise Exception.Create('Required PageControl component')
  else begin
    TabSheet := TTabSheet.Create(PageControl);
    TabSheet.Caption := Caption;
    TabSheet.PageControl := PageControl;
    PageControl.ActivePage := TabSheet;
    AFrame := T.Create(TabSheet);
    AFrame.Parent := TabSheet;
    AFrame.Align := alClient;
  end;
end;

procedure TPageControlFactory.SetPageControl(const aPageControl: TPageControl);
begin
  FPageControl := aPageControl;
end;

end.
