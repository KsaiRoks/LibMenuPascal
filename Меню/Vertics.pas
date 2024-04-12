unit Vertics;

interface

type
  PtrVertic = ^StackVertic;
  StackVertic = record
    Number: Integer;
    Name: string[20];
    Next: PtrVertic;
  end;
  
  PtrHorizont = ^StackHorizont;
  StackHorizont = record
    Number: Integer;
    Group: string[10];
    Head: PtrVertic;
    Next: PtrHorizont;
  end;

procedure MakeNewVertic(var Vertic: PtrVertic);
procedure MakeNewHorizont;
procedure PutVerticMenu(vertic: PtrVertic; n: integer);
procedure ChoiseMenuHorizont;
procedure MenuOfVertics;

implementation

uses
  crt, menu;

var
  Horizont: PtrHorizont;

procedure MakeNewVertic(var Vertic: PtrVertic);
var
  Top: PtrVertic;
  NameValue: string[20];
  k: integer;
begin
  k := 0;
  while NameValue <> 'n' do
  begin
    New(Top);
    Write('Введите фамилию ("n" для завершения): ');
    readln(NameValue);
    if NameValue <> 'n' then
    begin
      with Top^ do
      begin
        k := k + 1;
        Next := Vertic;
        Number := k;
        Name := NameValue;
      end;
      Vertic := Top;
    end;
  end;
end;

procedure MakeNewHorizont;
var
  Top: PtrHorizont;
  GroupValue: string[10];
  k: Integer;
  Vertic: PtrVertic;
begin
  k := 0;
  while GroupValue <> 'n' do
  begin
    New(Top);
    Write('Введите номер группы ("n" для завершения): ');
    Readln(GroupValue);
    if GroupValue <> 'n' then
    begin
      with Top^ do
      begin
        k := k + 1;
        Number := k;
        Group := GroupValue;
        Next := Horizont;
        Vertic := nil;
        MakeNewVertic(vertic);
        Head := vertic;
      end;
      Horizont := Top;
    end;
  end;
end;

procedure PutVerticMenu(vertic: PtrVertic; n: integer);
var
  Top: PtrVertic;
  PozX, PozY: integer;
begin
  Top := Vertic;
  PozY := 5;
  PozX := 12 * n - 7;
  while Top <> nil do
  begin
    PozY := PozY + 1;
    GoToXY(PozX, PozY);
    write(Top^.Name);
    Top := Top^.Next;
  end;
end;

procedure ChoiseMenuHorizont;
var
  Top: PtrHorizont;
  n, k: integer;
  repeatChoice: char;
begin
  while repeatChoice <> 'n' do
  begin
    Top := Horizont;
    n := 0;
    while Top <> nil do
    begin
      n := n + 1;
      GoToXY(12 * n - 7, 4);
      write(n, '. ', Top^.Group);
      Top := Top^.Next;
    end;
    GoToXY(5, 1);
    write('Выберите пункт меню: ');
    read(n);
    Top := Horizont;
    k := Horizont^.Number + 1;
    while Top^.Number + n <> k do
      Top := Top^.Next;
    PutVerticMenu(Top^.Head, n);
    GoToXY(5, 2);
    writeln('Нажмите n чтобы выйти');
    read(repeatChoice);
  end;
end;


procedure DrawVerticsMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('1. Создать Вертикальное меню');
  gotoxy(x, y + 1); write('Назад в главное меню');
end;

procedure MenuOfVertics;
const
  Items = 2;
var
  ok:     boolean;
  n:      byte;
begin
  ok := true; 
  while ok = true do
  begin
    DrawVerticsMenu(X, Y);
    n := SelectMenu(X - 2, Y, Items);
    case n of     
      1:
        begin
          clrscr;
          MakeNewHorizont;
          clrscr;
          ChoiseMenuHorizont;
          PressAnyKey;
        end;
      2:
        begin
          clrscr;
          ok := false;
        end;
    end;
  end;
end;

end.