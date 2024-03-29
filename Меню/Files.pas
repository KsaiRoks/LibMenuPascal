unit Files;

interface

type
  Student = record 
    Name: string[10];
    Mark: string[9]; 
  end;

procedure AddLine;
procedure MakeFile;
procedure AddFile;
procedure ViewFile(FileName: string);
procedure MenuOfFiles;

implementation

uses
  crt, menu;

var
  FileName: string[12];
  StudentFile: file of Student;
  FlowStudent: Student;

procedure AddLine;
var
  ch: char;
  OK: boolean;
begin
  OK := True;
  while Ok do
  begin
    writeln('Введите фамилию студента:');
    readln(FlowStudent.Name);
    writeln('Введите его оценку:');
    readln(FlowStudent.Mark);
    write(StudentFile, FlowStudent);
    write('Для завершения введите n: ');
    readln(ch);
    if ch = 'n' then
    begin
      OK := False;
    end;
  end;
end;

procedure MakeFile;
begin
  writeln('Дайте файлу имя');
  readln(FileName);
  Assign(StudentFile, FileName);
  Rewrite(StudentFile);
  AddLine;
  Close(StudentFile);
end;

procedure AddFile;
var
  TempFile: file of Student;
  TempStudent: Student;
  ch: char;
  OK: boolean;
begin
  writeln('Выберите файл для добавления информации:');
  readln(FileName);
  Assign(StudentFile, FileName);
  Reset(StudentFile);
  Assign(TempFile, 'temp.txt');
  Rewrite(TempFile);
  while not Eof(StudentFile) do
  begin
    read(StudentFile, TempStudent);
    write(TempFile, TempStudent);
  end;
  Close(StudentFile);
  Close(TempFile);
  Assign(StudentFile, FileName);
  Rewrite(StudentFile);
  Reset(TempFile);
  while not Eof(TempFile) do
  begin
    read(TempFile, FlowStudent);
    write(StudentFile, FlowStudent);
  end;
  Close(TempFile);
  Erase(TempFile);
  AddLine;
  Close(StudentFile);
end;

procedure ViewFile(FileName: string);
begin
  clrscr;
  writeln('Содержимое файла:');
  Assign(StudentFile, FileName);
  Reset(StudentFile);
  while not Eof(StudentFile) do
  begin
    read(StudentFile, FlowStudent);
    writeln('Фамилия: ', FlowStudent.Name);
    writeln('Оценки: ', FlowStudent.Mark);
  end;
  Close(StudentFile);
end;

procedure DrawFilesMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('Создать Файл');
  gotoxy(x, y + 1); write('Добавить элемент в Файл');
  gotoxy(x, y + 2); write('Просмотреть Файл');
  gotoxy(x, y + 3); write('Назад в главное меню');
end;

procedure MenuOfFiles;
const
  Items = 4;
var
  ok: boolean;
  n:      byte;
begin
  ok := true; 
  while ok = true do
  begin
    DrawFilesMenu(X, Y);
    n := SelectMenu(X - 2, Y, Items);
    case n of     
      1:
        begin
          clrscr;
          MakeFile;
          PressAnyKey;
        end;
      2:
        begin
          clrscr;
          AddFile;
          PressAnyKey;
        end;
      3:
        begin
          clrscr;
          writeln('Введите имя файла для просмотра:');
          readln(FileName);
          ViewFile(FileName);
          PressAnyKey;
        end;
      4:
        begin
          clrscr;
          ok := false;
        end;
    end;
  end;
end;

end.