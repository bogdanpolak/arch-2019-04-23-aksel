unit Main.DependencyInjectionContainer;

interface

procedure Execute_DependencyInjectionContainerDemo;

implementation

uses
  System.TypInfo,
  System.SysUtils,
  RTTI;

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------

type
  IDependency = interface
    ['{618030A2-DB17-4532-81D0-D5AA6F73DC66}']
    procedure IntroduceYourself;
  end;

  TDependencyA = class(TInterfacedObject, IDependency)
  public
    procedure IntroduceYourself;
  end;

  TDependencyB = class(TInterfacedObject, IDependency)
  public
    procedure IntroduceYourself;
  end;

  TConsumer = class
  private
    FDependency: IDependency;
  public
    constructor Create(aDependency: IDependency);
    procedure ProcessUsingDependency;
  end;

  { TDependencyA }

procedure TDependencyA.IntroduceYourself;
begin
  WriteLn('Instance of type TDependencyA');
end;

{ TDependencyB }

procedure TDependencyB.IntroduceYourself;
begin
  WriteLn('Instance of type TDependencyB');
end;

{ TConsumer }

constructor TConsumer.Create(aDependency: IDependency);
begin
  FDependency := aDependency;
end;

procedure TConsumer.ProcessUsingDependency;
begin
  if FDependency <> nil then
    FDependency.IntroduceYourself;
end;

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------

type
  TDependencyContainer = class
    FInterfaceGUID: TGUID;
    FClass: TClass;
  public
    function Reg<T: IInterface>(C: TClass): T;
    function Resolve<T: IInterface>: T;
  end;

function TDependencyContainer.Reg<T>(C: TClass): T;
var
  data: PTypeData;
begin
  data := System.TypInfo.GetTypeData(TypeInfo(T));
  if ifHasGuid in data.IntfFlags then
    FInterfaceGUID := data.Guid
  else
    raise Exception.Create('Unsupported interface. GUID is required');
  FClass := C;
end;

function TDependencyContainer.Resolve<T>: T;
var
  ctx: TRttiContext;
  Obj: TObject;
  rttiType: TRttiType;
  CreateMethod: TRttiMethod;
  Value: TValue;
  data: PTypeData;
begin
  data := System.TypInfo.GetTypeData(TypeInfo(T));
  if ifHasGuid in data.IntfFlags then
  begin
    if data.Guid = FInterfaceGUID then
    begin
      ctx := TRttiContext.Create;
      rttiType := ctx.GetType(FClass.ClassInfo);
      if rttiType <> nil then
      begin
        CreateMethod := rttiType.GetMethod('Create');
        Value := CreateMethod.Invoke(FClass, []);
        System.SysUtils.Supports(Value.AsInterface, data.Guid, Result);
      end;
    end
    else
      raise Exception.Create('Cant find Interface in Container');
  end
  else
    raise Exception.Create('Unsupported interface. GUID is required');
end;

// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------

type
  TOptionAB = (Option_A_, Option_B_);

  TAppConfiguration = record
    ExecutionOption: TOptionAB;
  end;

var
  GlobalAppConfiguration: TAppConfiguration = // ----
    (ExecutionOption: Option_B_);
  GlobalDependencyContainer: TDependencyContainer;

procedure DefineDependencies();
begin
  if GlobalAppConfiguration.ExecutionOption = Option_A_ then
    GlobalDependencyContainer.Reg<IDependency>(TDependencyA)
  else
    GlobalDependencyContainer.Reg<IDependency>(TDependencyB);
end;

procedure Execute_DependencyInjectionContainerDemo;
var
  Dependency: IDependency;
  SomeConsumerObj: TConsumer;
begin
  GlobalDependencyContainer := TDependencyContainer.Create;
  DefineDependencies();
  Dependency := GlobalDependencyContainer.Resolve<IDependency>;
  SomeConsumerObj := TConsumer.Create(Dependency);
  SomeConsumerObj.ProcessUsingDependency;
  SomeConsumerObj.Free;
  GlobalDependencyContainer.Free;
end;

end.
