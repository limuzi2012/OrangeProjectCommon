﻿unit UnitSM4Main;

(* ************************************************ *)
(*　　　　　　　　　　　　　　　　　　　　　　　　　*)
(*　　修改：爱吃猪头肉 & Flying Wang 2015-04-24　　 *)
(*　　　　　　上面的版权声明请不要移除。　　　　　　*)
(*　　　　　　　　　　　　　　　　　　　　　　　　　*)
(*　　　    　　　禁止发布到城通网盘。　　　  　　　*)
(*　　　　　　　　　　　　　　　　　　　　　　　　　*)
(* ************************************************ *)

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Edit,
  FMX.Layouts, FMX.Memo, FMX.ScrollBox, FMX.Controls.Presentation;

type
  TFormMain = class(TForm)
    Button2: TButton;
    Memo1: TMemo;
    Button3: TButton;
    Memo2: TMemo;
    Edit1: TEdit;
    Label1: TLabel;
    RadioButton_Ansi: TRadioButton;
    RadioButton_Wide: TRadioButton;
    RadioButton_UTF8: TRadioButton;
    Popup1: TPopup;
    Label2: TLabel;
    ProgressBarMain: TProgressBar;
    CheckBoxCBC: TCheckBox;
    CheckBoxPKCS: TCheckBox;
    RadioButtonHex: TRadioButton;
    RadioButton64: TRadioButton;
    Label3: TLabel;
    Edit2: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
  System.NetEncoding,
  FlyUtils.CnSM4, FlyUtils.CnXXX.Common;

function SM4EncryptStrToBase64(Value, Key: string; StrEncoding: TEncoding = nil;
  KeyEncoding: TEncoding = nil;
  InitVectorStr: string = ''; APaddingMode: TPaddingMode = TPaddingMode.pmPKCS5or7RandomPadding; CBCMode: Boolean = True;
  ValueCRLFMode: TCRLFMode = rlCRLF;
  KeyCRLFMode: TCRLFMode = rlCRLF;
  OnProcessProc: TOnProcessProc = nil; ProcessProc: TProcessProc = nil): string;
begin
  Result := EncodeBase64Bytes(SM4EncryptStr(Value, Key, StrEncoding, KeyEncoding, InitVectorStr,
    APaddingMode, CBCMode, ValueCRLFMode,
    KeyCRLFMode, OnProcessProc, ProcessProc));
end;

function SM4DecryptStrFromBase64(StrHex, Key: string;
  ResultEncoding: TEncoding = nil; KeyEncoding: TEncoding = nil;
  InitVectorStr: string = ''; APaddingMode: TPaddingMode = TPaddingMode.pmPKCS5or7RandomPadding; CBCMode: Boolean = True;
  ResultCRLFMode: TCRLFMode = rlCRLF;
  KeyCRLFMode: TCRLFMode = rlCRLF;
  OnProcessProc: TOnProcessProc = nil; ProcessProc: TProcessProc = nil): string;
begin
  Result := SM4DecryptStr(DecodeBase64Bytes(StrHex), Key, ResultEncoding, KeyEncoding,
    InitVectorStr, APaddingMode, CBCMode, ResultCRLFMode,
    KeyCRLFMode, OnProcessProc, ProcessProc);
end;

procedure TFormMain.Process(Sender: TObject; Min, Max, Done: UInt64; var Cancel: Boolean);
begin
  ProgressBarMain.Max := Max;
  ProgressBarMain.Min := Min;
  ProgressBarMain.Value := Done;
  Application.ProcessMessages;
  Cancel := False;
end;

procedure TFormMain.Button2Click(Sender: TObject);
var
  APaddingMode: TPaddingMode;
begin
  APaddingMode := TPaddingMode.pmZeroPadding;
  if CheckBoxPKCS.IsChecked then
    APaddingMode := TPaddingMode.pmPKCS5or7RandomPadding;
  if RadioButtonHex.IsChecked then
  begin
    if RadioButton_Ansi.IsChecked then
    begin
      Memo2.Text := SM4EncryptStrToHex(Memo1.Text.Trim, Edit1.Text, TEncoding.ANSI, TEncoding.UTF8,
        Edit1.Text, APaddingMode, CheckBoxCBC.IsChecked,
        rlCRLF, rlCRLF, Process);
    end;
    if RadioButton_Wide.IsChecked then
    begin
      Memo2.Text := SM4EncryptStrToHex(Memo1.Text.Trim, Edit1.Text, TEncoding.Unicode, TEncoding.UTF8,
        Edit1.Text, APaddingMode, CheckBoxCBC.IsChecked,
        rlCRLF, rlCRLF, Process);
    end;

    if RadioButton_UTF8.IsChecked then
    begin
      Memo2.Text := SM4EncryptStrToHex(Memo1.Text.Trim, Edit1.Text, TEncoding.UTF8, TEncoding.UTF8,
        Edit1.Text, APaddingMode, CheckBoxCBC.IsChecked,
        rlCRLF, rlCRLF, Process);
    end;
  end
  else
  begin
    if RadioButton_Ansi.IsChecked then
    begin
      Memo2.Text := SM4EncryptStrToBase64(Memo1.Text.Trim, Edit1.Text, TEncoding.ANSI, TEncoding.UTF8,
        Edit1.Text, APaddingMode, CheckBoxCBC.IsChecked,
        rlCRLF, rlCRLF, Process);
    end;
    if RadioButton_Wide.IsChecked then
    begin
      Memo2.Text := SM4EncryptStrToBase64(Memo1.Text.Trim, Edit1.Text, TEncoding.Unicode, TEncoding.UTF8,
        Edit1.Text, APaddingMode, CheckBoxCBC.IsChecked,
        rlCRLF, rlCRLF, Process);
    end;

    if RadioButton_UTF8.IsChecked then
    begin
      Memo2.Text := SM4EncryptStrToBase64(Memo1.Text.Trim, Edit1.Text, TEncoding.UTF8, TEncoding.UTF8,
        Edit1.Text, APaddingMode, CheckBoxCBC.IsChecked,
        rlCRLF, rlCRLF, Process);
    end;
  end;
end;

procedure TFormMain.Button3Click(Sender: TObject);
var
  APaddingMode: TPaddingMode;
begin
  APaddingMode := TPaddingMode.pmZeroPadding;
  if CheckBoxPKCS.IsChecked then
    APaddingMode := TPaddingMode.pmPKCS5or7RandomPadding;
  if RadioButtonHex.IsChecked then
  begin
    if RadioButton_Ansi.IsChecked then
    begin
      Memo1.Text := SM4DecryptStrFromHex(Memo2.Text.Trim, Edit1.Text, TEncoding.ANSI, TEncoding.UTF8,
        Edit1.Text, APaddingMode, CheckBoxCBC.IsChecked,
        rlCRLF, rlCRLF, Process);
    end;
    if RadioButton_Wide.IsChecked then
    begin
      Memo1.Text := SM4DecryptStrFromHex(Memo2.Text.Trim, Edit1.Text, TEncoding.Unicode, TEncoding.UTF8,
        Edit1.Text, APaddingMode, CheckBoxCBC.IsChecked,
        rlCRLF, rlCRLF, Process);
    end;

    if RadioButton_UTF8.IsChecked then
    begin
      Memo1.Text := SM4DecryptStrFromHex(Memo2.Text.Trim, Edit1.Text, TEncoding.UTF8, TEncoding.UTF8,
        Edit1.Text, APaddingMode, CheckBoxCBC.IsChecked,
        rlCRLF, rlCRLF, Process);
    end;
  end
  else
  begin
    if RadioButton_Ansi.IsChecked then
    begin
      Memo1.Text := SM4DecryptStrFromBase64(Memo2.Text.Trim, Edit1.Text, TEncoding.ANSI, TEncoding.UTF8,
        Edit1.Text, APaddingMode, CheckBoxCBC.IsChecked,
        rlCRLF, rlCRLF, Process);
    end;
    if RadioButton_Wide.IsChecked then
    begin
      Memo1.Text := SM4DecryptStrFromBase64(Memo2.Text.Trim, Edit1.Text, TEncoding.Unicode, TEncoding.UTF8,
        Edit1.Text, APaddingMode, CheckBoxCBC.IsChecked,
        rlCRLF, rlCRLF, Process);
    end;

    if RadioButton_UTF8.IsChecked then
    begin
      Memo1.Text := SM4DecryptStrFromBase64(Memo2.Text.Trim, Edit1.Text, TEncoding.UTF8, TEncoding.UTF8,
        Edit1.Text, APaddingMode, CheckBoxCBC.IsChecked,
        rlCRLF, rlCRLF, Process);
    end;
  end;
end;

end.
