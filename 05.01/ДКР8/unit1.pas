unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ComboBox1Change(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
var k:integer;
  p, i, s:real;
begin
  if (Edit1.Text='') or (Edit2.Text='') or (Edit3.Text='') then
     begin
     ShowMessage('Заполните все поля')
     end
  else
  begin
  Memo1.Lines.clear;
  k:=StrToInt(Edit1.Text);
  s:=StrToInt(Edit3.Text);
  p:=StrToFloat(Edit2.Text);
  if (Combobox1.ItemIndex = 0)then
     begin
     i:=k*s*(p/100);
     s:=s+i;
     end;
  if (combobox1.ItemIndex = 1) then
     begin
     while k>0 do
     begin
       i:=s*(p/100);
       s:=s+i;
       k:=k-1;
     end;
     end;
Memo1.Lines.add('Тип процентов: '+Combobox1.Text);
Memo1.Lines.add('Кол-во дней: '+Edit1.Text);
Memo1.Lines.add('Проценты за день: '+Edit2.Text+'%');
Memo1.Lines.add('Начальная сумма: '+Edit3.Text);
Memo1.Lines.add('Итоговая сумма: '+FloatToStr(s));
  end;
end;

end.

