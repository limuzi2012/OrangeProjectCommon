﻿unit UnitCRCMain;

(* ************************************************ *)
(*　　　　　　　　　　　　　　　　　　　　　　　　　*)
(*　　修改：爱吃猪头肉 & Flying Wang 2016-02-29　　 *)
(*　　　　　　上面的版权声明请不要移除。　　　　　　*)
(*　　　　　　　　　　　　　　　　　　　　　　　　　*)
(*　　　    　　　禁止发布到城通网盘。　　　  　　　*)
(*　　　　　　　　　　　　　　　　　　　　　　　　　*)
(* ************************************************ *)

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.Memo,
  FMX.ScrollBox, FMX.Controls.Presentation;

type
  TFormMain = class(TForm)
    Button2: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    RadioButton_Ansi: TRadioButton;
    RadioButton_Wide: TRadioButton;
    RadioButton_UTF8: TRadioButton;
    Popup1: TPopup;
    Label2: TLabel;
    ProgressBarMain: TProgressBar;
    RadioButton32: TRadioButton;
    RadioButton64: TRadioButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure Process(Sender: TObject; Min, Max, Done: UInt64; var Cancel: Boolean);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

uses
  FlyUtils.CnCRC32, FlyUtils.CnXXX.Common;

procedure TFormMain.Process(Sender: TObject; Min, Max, Done: UInt64; var Cancel: Boolean);
begin
  ProgressBarMain.Max := Max;
  ProgressBarMain.Min := Min;
  ProgressBarMain.Value := Done;
  Application.ProcessMessages;
  Cancel := False;
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
  if RadioButton32.IsChecked then
  begin
    if RadioButton_Ansi.IsChecked then
    begin
      Memo2.Text := GetCrc32StrToHex(Memo1.Text.Trim, TEncoding.ANSI, rlCRLF, 0, Process);
    end;
    if RadioButton_Wide.IsChecked then
    begin
      Memo2.Text := GetCrc32StrToHex(Memo1.Text.Trim,  TEncoding.Unicode, rlCRLF, 0, Process);
    end;

    if RadioButton_UTF8.IsChecked then
    begin
      Memo2.Text := GetCrc32StrToHex(Memo1.Text.Trim, TEncoding.UTF8, rlCRLF, 0, Process);
    end;
  end
  else
  begin
    if RadioButton_Ansi.IsChecked then
    begin
      Memo2.Text := GetCrc64StrToHex(Memo1.Text.Trim, TEncoding.ANSI, rlCRLF, 0, Process);
    end;
    if RadioButton_Wide.IsChecked then
    begin
      Memo2.Text := GetCrc64StrToHex(Memo1.Text.Trim,  TEncoding.Unicode, rlCRLF, 0, Process);
    end;

    if RadioButton_UTF8.IsChecked then
    begin
      Memo2.Text := GetCrc64StrToHex(Memo1.Text.Trim, TEncoding.UTF8, rlCRLF, 0, Process);
    end;
  end;
end;

end.
