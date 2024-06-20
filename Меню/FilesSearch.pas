unit FilesSearch;

interface

procedure MakeAndAddText;
procedure MyWrite(stroke: string);
procedure ViewText;
procedure BadBoys(Exam: byte);
procedure Heroes;
procedure Veterans;
procedure MenuOfFilesSearch;

implementation

uses
  crt, menu;

procedure MakeAndAddText;
var
  ch: char;
  ok: boolean;
  TextName: string[12];
  Name: string[10];
  Mark: string[5];
  StudentText: text;

begin
  write('Введите имя файла: ');
  readln(TextName);
  assign(StudentText, TextName);
  {$I-} append(StudentText);{$I+}
  ch := 'y';
  if not FileExists(TextName) then
    rewrite(StudentText);
  while ch in ['y', 'Y', 'н', 'Н'] do
  begin
    write('Введите фамилию студента: ');
    readln(Name);
    write('Введите его оценки: ');
    readln(Mark);
    write(StudentText, Name: 10, Mark: 5);
    write('Нажмите n для продолжения: ');
    readln(ch);
  end;
  close(StudentText)
end;

procedure MyWrite(stroke: string);
var
  result: string;
  i, n: byte;
begin
  result := stroke; 
  n := length(stroke);
  i := 1;
  while (result[i] = ' ') and (i <= n) do
    i := i + 1;
  delete(result, 1, i - 1);
  write(result);
end;

procedure ViewText;
var
  k: byte;
  ch: char;
  TextName: string[12];
  Name: string[10];
  Mark: string[5];
  StudentText: text;

begin
  clrscr;
  k := 3;
  writeln('Введите имя файла');
  readln(TextName);
  assign(StudentText, TextName);
  {$I-}reset(StudentText);{$I+}
  if not FileExists(TextName) then
    writeln('Файл ', TextName, ' не найден :(')
    else
  begin
    while not EOF(StudentText) do
    begin
      k := k + 1;
      read(StudentText, Name, Mark);
      GoToXY(1, k); MyWrite(Name);
      GoToXY(12, k); write(Mark);
      writeln();
    end;
    close(StudentText);
  end;
end;

procedure BadBoys(Exam: byte);
var
  k: byte;
  TextName: string[12];
  Name: string[10];
  Mark: string[5];
  StudentText: text;
begin
  k := 3;
  writeln('Введите имя файла');
  readln(TextName);
  assign(StudentText, TextName);
  {$I-}reset(StudentText);{$I+}
  if not FileExists(TextName) then
    writeln('Файл ', TextName, ' не найден :(')
    else
  begin
    if(Exam = 1) then 
    begin
      GoToXY(1, 2); writeln('Двоечники по матанализу:')
    end;
    if(Exam = 3) then 
    begin
      GoToXY(1, 2); writeln('Двоечники по АиГ:')
    end;
    if(Exam = 5) then 
    begin
      GoToXY(1, 2); writeln('Двоечники по ОП:')
    end;
    while not EOF(StudentText) do
    begin
      read(StudentText, Name, Mark);
      if Mark[Exam] = '2' then
      begin
        k := k + 1;
        GoToXY(1, k); MyWrite(Name);
        GoToXY(12, k); write(Mark);
        writeln();
      end;
      writeln();
    end;
    close(StudentText);
  end;
end;

procedure Heroes;
var
  k: byte;
  i, n: integer;
  TextName: string[12];
  Name: string[10];
  Mark: string[5];
  StudentText: text;
begin
  k := 3;
  writeln('Введите имя файла');
  readln(TextName);
  assign(StudentText, TextName);
  {$I-}reset(StudentText);{$I+}
  if not FileExists(TextName) then
    writeln('Файл ', TextName, ' не найден :(')
  else
while not EOF(StudentText) do
    begin
      GoToXY(1, 2); write('Две двойки: ');
      n := 0;
      read(StudentText, Name, Mark);
      for i := 0 to length(Mark) do
      begin
        if Mark[i] = '2' then n := n + 1
      end;
      if n = 2 then
      begin
        k := k + 1;
        GoToXY(1, k); MyWrite(Name);
        GoToXY(12, k); write(Mark);
        writeln();
      end;
      writeln();
    end;
  close(StudentText);
end;

procedure Veterans;
var
  k: byte;
  i, n: integer;
  TextName: string[12];
  Name: string[10];
  Mark: string[5];
  StudentText: text;
begin
  k := 3;
  writeln('Введите имя файла');
  readln(TextName);
  assign(StudentText, TextName);
  {$I-}reset(StudentText);{$I+}
  if not FileExists(TextName) then
    writeln('Файл ', TextName, ' не найден :(')
  else
    while not EOF(StudentText) do
    begin
      GoToXY(1, 2); write('Все двойки: ');
      n := 0;
      read(StudentText, Name, Mark);
      for i := 0 to length(Mark) do
      begin
        if Mark[i] = '2' then n := n + 1
      end;
      if n = 3 then
      begin
        k := k + 1;
        GoToXY(1, k); MyWrite(Name);
        GoToXY(12, k); write(Mark);
        writeln();
      end;
      writeln();
    end;
  close(StudentText);
end;

procedure DrawFilesSearchMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('1. Создать Файл');
  gotoxy(x, y + 1); write('2. Просмотреть Файл');
  gotoxy(x, y + 2); write('3. Двоешники по ОмА');
  gotoxy(x, y + 3); write('4. Двоешники по АиГ');
  gotoxy(x, y + 4); write('5. Двоешники по ОП');
  gotoxy(x, y + 5); write('6. Две двойки');
  gotoxy(x, y + 6); write('7. Все двойки');
  gotoxy(x, y + 7); write('Назад в главное меню');
end;

procedure MenuOfFilesSearch;
const
  Items = 8;
var
  ok: boolean;
  n:      byte;
begin
  ok := true; 
  while ok = true do
  begin
    DrawFilesSearchMenu(X, Y);
    n := SelectMenu(X - 2, Y, Items);
    case n of     
      1:
        begin
          clrscr;
          MakeAndAddText;
          PressAnyKey;
        end;
      2:
        begin
          clrscr;
          ViewText;
          PressAnyKey;
        end;
      3:
        begin
          clrscr;
          BadBoys(1);
          PressAnyKey;
        end;
      4:
        begin
          clrscr;
          BadBoys(3);
          PressAnyKey;
        end;
      5:
        begin
          clrscr;
          BadBoys(5);
          PressAnyKey;
        end;
      6:
        begin
          clrscr;
          Heroes;
          PressAnyKey;
        end;
      7:
        begin
          clrscr;
          Veterans;
          PressAnyKey;
        end;
      8:
        begin
          clrscr;
          ok := false;
        end;
    end;
  end;
end;

end.