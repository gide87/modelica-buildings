within Buildings.BuildingLoads.EnergyPlusModels.BaseClasses;
model E_fmu
  "EnergyPlus model of building E exported as FMU and imported as Modelica model"
  // Model automatically generated by Dymola from FMI model description
  extends BaseClasses.Template_fmu(fmi_instanceName="E_fmu");
protected
fmi_Functions.fmiModel fmi;
Boolean fmi_StepOK;
Boolean sorting1(start=false);
Boolean sorting2(start=false);
parameter Real fmi_Initialized(fixed=false);
parameter Real fmi_AParamsAndStart(fixed=false);
parameter Real fmi_initInput0(start=0,fixed=false);
parameter Real fmi_initInput1(start=0,fixed=false);
package fmi_Functions
  class fmiModel
  extends ExternalObject;
    function constructor "Initialize FMI model"
      extends Modelica.Icons.Function;
      input String instanceName;
      input Boolean loggingOn;
        input String fmuLocation;
      output fmiModel fmi;
      external"C" fmi = E_fmiInstantiateModel2(instanceName, loggingOn, fmuLocation)
      annotation(Header="
#ifndef EFMI_C
#define EFMI_C 1
#include \"FMI/fmiFunctions_.h\"
#include \"FMI/fmiImport.h\"
#endif
#ifndef E_Instantiate_C
#define E_Instantiate_C 1
#include <stdlib.h>
#ifndef E_MYSTRCMP_C
#define E_MYSTRCMP_C 1
int Emystrcmp(const void *_a, const void *_b) {
  char *a = _a;
  char *const *b = _b;
  return strcmp(a, *b);
}
#endif
void ELogger(fmiComponent c, fmiString instanceName, fmiStatus status,
         fmiString category, fmiString message, ...) {
  char msg[4096];
  char buf[4096];
  char fmsg[4096];
  int len;
  va_list ap;
  strcpy(fmsg,message);
  va_start(ap,fmsg);
#if defined(_MSC_VER) && _MSC_VER>=1200
  len = _snprintf(msg, sizeof(fmsg)/sizeof(*fmsg), \"%s: %s\", instanceName, fmsg);
  if (len < 0) goto fail;
  len = _vsnprintf(buf, sizeof(buf)/sizeof(*buf) - 2, msg, ap);
  if (len < 0) goto fail;
#else
  len = snprintf(msg, sizeof(msg)/sizeof(*msg), \"%s: %s\", instanceName, fmsg);
  if (len < 0) goto fail;
  len = vsnprintf(buf, sizeof(buf)/sizeof(*buf) - 2, msg, ap);
  if (len < 0) goto fail;
#endif
  buf[len] = '\\n';
  buf[len + 1] = 0;
  va_end(ap);
  switch (status) {
    case fmiFatal:
      ModelicaError(buf);
      break;
    default:
     ModelicaMessage(buf);
     break;
  }
  return;
fail:
  ModelicaMessage(\"Logger failed, message too long?\");
}
void * E_fmiInstantiateModel2(const char*instanceName, fmiBoolean loggingOn, const char* fmuLocation) {
  static fmiCoSimCallbackFunctions funcs = {&ELogger, &calloc, &free, NULL};
  struct dy_Extended* res;

  res = calloc(1, sizeof(struct dy_Extended));
  if (res!=0) {
    if (!(res->hInst=LoadLibrary(\"E.so\"))) {
      ModelicaError(\"Loading of FMU dynamic link library (E.so) failed!\");
      return 0;
    }
    if(!(res->dyFmiInstantiateSlave=(fmiInstantiateSlaveFunc)GetProcAddress(res->hInst,\"E_fmiInstantiateSlave\"))){
      ModelicaError(\"GetProcAddress failed for fmiInstantiateSlave!\");
      return 0;
    }
    if (!(res->dyFmiFreeSlaveInstance=(fmiFreeSlaveInstanceFunc)GetProcAddress(res->hInst,\"E_fmiFreeSlaveInstance\"))) {
      ModelicaError(\"GetProcAddress failed for fmiFreeSlaveInstance!\");
      return 0;
    }
    if (!(res->dyFmiInitializeSlave=(fmiInitializeSlaveFunc)GetProcAddress(res->hInst,\"E_fmiInitializeSlave\"))) {
      ModelicaError(\"GetProcAddress failed for fmiInitializeSlave!\");
      return 0;
    }
    if (!(res->dyFmiDoStep=(fmiDoStepFunc)GetProcAddress(res->hInst,\"E_fmiDoStep\"))) {
      ModelicaError(\"GetProcAddress failed for fmiDoStep!\");
      return 0;
    }
    if (!(res->dyFmiTerminateSlave=(fmiTerminateSlaveFunc)GetProcAddress(res->hInst,\"E_fmiTerminateSlave\"))) {
      ModelicaError(\"GetProcAddress failed for fmiTerminateSlave!\");
      return 0;
    }
    if (!(res->dyFmiSetReal=(fmiSetRealFunc)GetProcAddress(res->hInst,\"E_fmiSetReal\"))) {
      ModelicaError(\"GetProcAddress failed for fmiSetReal!\");
      return 0;
    }
    if (!(res->dyFmiGetReal=(fmiGetRealFunc)GetProcAddress(res->hInst,\"E_fmiGetReal\"))) {
      ModelicaError(\"GetProcAddress failed for fmiGetReal!\");
      return 0;
    }
    if (!(res->dyFmiSetInteger=(fmiSetIntegerFunc)GetProcAddress(res->hInst,\"E_fmiSetInteger\"))) {
      ModelicaError(\"GetProcAddress failed for fmiSetInteger!\");
      return 0;
    }
    if (!(res->dyFmiGetInteger=(fmiGetIntegerFunc)GetProcAddress(res->hInst,\"E_fmiGetInteger\"))) {
      ModelicaError(\"GetProcAddress failed for fmiGetInteger!\");
      return 0;
    }
    if (!(res->dyFmiSetBoolean=(fmiSetBooleanFunc)GetProcAddress(res->hInst,\"E_fmiSetBoolean\"))) {
      ModelicaError(\"GetProcAddress failed for fmiSetBoolean!\");
      return 0;
    }
    if (!(res->dyFmiGetBoolean=(fmiGetBooleanFunc)GetProcAddress(res->hInst,\"E_fmiGetBoolean\"))) {
      ModelicaError(\"GetProcAddress failed for fmiGetBoolean!\");
      return 0;
    }
    res->m=res->dyFmiInstantiateSlave(instanceName, \"d9b619c3cab82b4ec160942d29aa5c00\", fmuLocation, \"application/x-dymolakernel\", 0, fmiFalse, fmiFalse, funcs, loggingOn);
    if (0==res->m) {free(res);res=0;ModelicaError(\"InstantiateSlave failed\");}
    else {res->dyTriggered=0;res->dyTime=res->dyLastTime=-1e37;}
  }
  return res;
}
#endif", Library="E", LibraryDirectory="modelica://Buildings/Resources/Library/FMU/E/binaries",
                                                                                            __Dymola_doNotLinkSharedObject=true);
    end constructor;

    function destructor "Release storage of FMI model"
      extends Modelica.Icons.Function;
      input fmiModel fmi;
      external"C"
                 E_fmiFreeModelInstance2(fmi);
      annotation (Header="
#ifndef EFMI_C
#define EFMI_C 1
#include \"FMI/fmiFunctions_.h\"
#include \"FMI/fmiImport.h\"
#endif
#ifndef E_Free_C
#define E_Free_C 1
#include <stdlib.h>
void E_fmiFreeModelInstance2(void*m) {
  struct dy_Extended*a=m;
  if (a) {
    a->dyFmiTerminateSlave(a->m);
    a->dyFmiFreeSlaveInstance(a->m);
    FreeLibrary(a->hInst);
    free(a);
  }
}
#endif", Library="E", LibraryDirectory="modelica://Buildings/Resources/Library/FMU/E/binaries",
                                                                                            __Dymola_doNotLinkSharedObject=true);
    end destructor;
  end fmiModel;

    function fmiInitializeSlave
      input fmiModel fmi;
      input Real tStart;
      input Boolean forceShutDownAtTStop;
       input Real tStop;
      input Real preAvailable;
      output Real postAvailable=preAvailable;
      external"C" E_fmiInitializeSlave2(fmi, tStart, forceShutDownAtTStop, tStop);
      annotation (Header="
#ifndef EFMI_C
#define EFMI_C 1
#include \"FMI/fmiFunctions_.h\"
#include \"FMI/fmiImport.h\"
#endif
#ifndef E_InitializeSlave_C
#define E_InitializeSlave_C 1
#include <stdlib.h>
double E_fmiInitializeSlave2(void*m, fmiReal tStart, fmiBoolean forceShutDownAtTStop, fmiReal tStop) {
  struct dy_Extended*a=m;
  fmiStatus status=fmiFatal;
  if (a) {
    status=a->dyFmiInitializeSlave(a->m, tStart, forceShutDownAtTStop, tStop);
    a->dyTriggered=0;
    a->dyLastTime=a->dyTime;
  }
  if (status!=fmiOK && status!=fmiWarning) ModelicaError(\"InitializeSlave failed\");
  return 1e37;
}
#endif", Library="E", LibraryDirectory="modelica://Buildings/Resources/Library/FMU/E/binaries",
                                                                                            __Dymola_doNotLinkSharedObject=true);
    end fmiInitializeSlave;

   function fmiDoStep
     input fmiModel fmi;
     input Real currentTime;
     input Real stepSize;
     input Real preAvailable;
     output Boolean stepOK;
     output Real postAvailable=preAvailable;
     external"C" stepOK =
                         E_fmiDoStep2(fmi, currentTime, stepSize);
     annotation (Header="
#ifndef EFMI_C
#define EFMI_C 1
#include \"FMI/fmiFunctions_.h\"
#include \"FMI/fmiImport.h\"
#endif
#ifndef E_DoStep_C
#define E_DoStep_C 1
#include <stdlib.h>
double E_fmiDoStep2(void*m, double currentTime, double stepSize) {
  struct dy_Extended*a=m;
  fmiStatus status=fmiFatal;
  if (a) {
    status=a->dyFmiDoStep(a->m, currentTime, stepSize, fmiTrue);
  }
  if (status!=fmiOK && status!=fmiWarning) ModelicaError(\"DoStep failed\");
  return 1.0;
}
#endif", Library="E", LibraryDirectory="modelica://Buildings/Resources/Library/FMU/E/binaries",
                                                                                            __Dymola_doNotLinkSharedObject=true);
   end fmiDoStep;

    function fmiSetReal
      input fmiModel fmi;
      input Integer refs[:];
      input Real vals[size(refs, 1)];
      input Real preAvailable;
      output Real postAvailable= preAvailable;
      external"C"
                 E_fmiSetReal2(
        fmi,
        refs,
        size(refs, 1),
        vals);
        annotation (Header="
#ifndef EFMI_C
#define EFMI_C 1
#include \"FMI/fmiFunctions_.h\"
#include \"FMI/fmiImport.h\"
#endif
#ifndef E_SetReal_C
#define E_SetReal_C 1
#include <stdlib.h>
void E_fmiSetReal2(void*m, const int*refs, size_t nrefs, const double*vals) {
  struct dy_Extended*a=m;
  fmiStatus status=fmiFatal;
  if (a) {
    status=a->dyFmiSetReal(a->m, refs, nrefs, vals);
  }
  if (status!=fmiOK && status!=fmiWarning) ModelicaError(\"SetReal failed\");
}
#endif", Library="E", LibraryDirectory="modelica://Buildings/Resources/Library/FMU/E/binaries",
                                                                                            __Dymola_doNotLinkSharedObject=true);
    end fmiSetReal;

    function fmiGetRealScalar
      input fmiModel fmi;
      input Integer ref;
      output Real val;
      input Real preAvailable;
    algorithm
        val := scalar(fmiGetReal(fmi, {ref}, preAvailable));
    end fmiGetRealScalar;

    function fmiGetReal
      input fmiModel fmi;
      input Integer refs[:];
      output Real vals[size(refs, 1)];
      input Real preAvailable;
      external"C" E_fmiGetReal2(
        fmi,
        refs,
        size(refs, 1),
        vals);
      annotation (Header="
#ifndef EFMI_C
#define EFMI_C 1
#include \"FMI/fmiFunctions_.h\"
#include \"FMI/fmiImport.h\"
#endif
#ifndef E_GetReal_C
#define E_GetReal_C 1
#include <stdlib.h>
void E_fmiGetReal2(void*m, const int*refs, size_t nrefs, double*vals) {
  struct dy_Extended*a=m;
  fmiStatus status=fmiFatal;
  if (a) {
    status=a->dyFmiGetReal(a->m, refs, nrefs, vals);
  }
  if (status!=fmiOK && status!=fmiWarning) ModelicaError(\"GetReal failed\");
}
#endif", Library="E", LibraryDirectory="modelica://Buildings/Resources/Library/FMU/E/binaries",
                                                                                            __Dymola_doNotLinkSharedObject=true);
    end fmiGetReal;

    function fmiGetIntegerScalar
      input fmiModel fmi;
      input Integer ref;
      output Integer val;
      input Integer preAvailable;
    algorithm
        val := scalar(fmiGetInteger(fmi, {ref}, preAvailable));
    end fmiGetIntegerScalar;

    function fmiGetInteger
      input fmiModel fmi;
      input Integer refs[:];
      output Integer vals[size(refs, 1)];
      input Integer preAvailable;
      external"C" E_fmiGetInteger2(
        fmi,
        refs,
        size(refs, 1),
        vals);
      annotation (Header="
#ifndef EFMI_C
#define EFMI_C 1
#include \"FMI/fmiFunctions_.h\"
#include \"FMI/fmiImport.h\"
#endif
#ifndef E_GetInteger_C
#define E_GetInteger_C 1
#include <stdlib.h>
void E_fmiGetInteger2(void*m, const int*refs, size_t nrefs, int*vals) {
  struct dy_Extended*a=m;
  fmiStatus status=fmiFatal;
  if (a) {
    status=a->dyFmiGetInteger(a->m, refs, nrefs, vals);
  }
  if (status!=fmiOK && status!=fmiWarning) ModelicaError(\"GetInteger failed\");
}
#endif", Library="E", LibraryDirectory="modelica://Buildings/Resources/Library/FMU/E/binaries",
                                                                                            __Dymola_doNotLinkSharedObject=true);
    end fmiGetInteger;

    function fmiSetInteger
    input fmiModel fmi;
      input Integer refs[:];
      input Integer vals[size(refs, 1)];
      input Real preAvailable;
      output Real postAvailable=preAvailable;
      external"C" E_fmiSetInteger2(
        fmi,
        refs,
        size(refs, 1),
        vals);
        annotation (Header="
#ifndef EFMI_C
#define EFMI_C 1
#include \"FMI/fmiFunctions_.h\"
#include \"FMI/fmiImport.h\"
#endif
#ifndef E_SetInteger_C
#define E_SetInteger_C 1
#include <stdlib.h>
void E_fmiSetInteger2(void*m, const int*refs, size_t nrefs, int*vals) {
  struct dy_Extended*a=m;
  fmiStatus status=fmiFatal;
  if (a) {
    status=a->dyFmiSetInteger(a->m, refs, nrefs, vals);
  }
  if (status!=fmiOK && status!=fmiWarning) ModelicaError(\"SetInteger failed\");
}
#endif", Library="E", LibraryDirectory="modelica://Buildings/Resources/Library/FMU/E/binaries",
                                                                                            __Dymola_doNotLinkSharedObject=true);
    end fmiSetInteger;

    function fmiGetBooleanScalar
      input fmiModel fmi;
      input Integer ref;
      output Boolean val;
      input Integer preAvailable;
    algorithm
        val := scalar(fmiGetBoolean(fmi, {ref}, preAvailable));
    end fmiGetBooleanScalar;

    function fmiGetBoolean
      input fmiModel fmi;
      input Integer refs[:];
      output Boolean vals[size(refs, 1)];
      input Integer preAvailable;
      external"C" E_fmiGetBoolean2(
        fmi,
        refs,
        size(refs, 1),
        vals);
        annotation (Header="
#ifndef EFMI_C
#define EFMI_C 1
#include \"FMI/fmiFunctions_.h\"
#include \"FMI/fmiImport.h\"
#endif
#ifndef E_GetBoolean_C
#define E_GetBoolean_C 1
void E_fmiGetBoolean2(void*m, const int* refs, size_t nr, int* vals) {
  int i;
  struct dy_Extended*a=m;
  fmiStatus status=fmiFatal;
  if (a) {
    status=a->dyFmiGetBoolean(a->m, refs, nr, (fmiBoolean*)(vals));
  }
  if (status!=fmiOK && status!=fmiWarning) ModelicaError(\"GetBoolean failed\");
  for(i=nr-1;i>=0;i--) vals[i]=((fmiBoolean*)(vals))[i];
}
#endif", Library="E", LibraryDirectory="modelica://Buildings/Resources/Library/FMU/E/binaries",
                                                                                            __Dymola_doNotLinkSharedObject=true);
    end fmiGetBoolean;

    function fmiSetBoolean
      input fmiModel fmi;
      input Integer refs[:];
      input Boolean vals[size(refs, 1)];
      input Integer preAvailable;
      output Integer postAvailable=preAvailable;
    protected
      Boolean dummy[size(refs, 1)];
      external"C" E_fmiSetBoolean2(
        fmi,
        refs,
        size(refs, 1),
        vals,
        dummy);
        annotation (Header="
#ifndef EFMI_C
#define EFMI_C 1
#include \"FMI/fmiFunctions_.h\"
#include \"FMI/fmiImport.h\"
#endif
#ifndef E_SetBoolean_C
#define E_SetBoolean_C 1
void E_fmiSetBoolean2(void*m, const int* refs, size_t nr, const int* vals,int*dummy) {
  int i;
  struct dy_Extended*a=m;
  fmiStatus status=fmiFatal;
  for(i=0;i<nr;++i) ((fmiBoolean*)(dummy))[i]=vals[i];
  if (a) {
    status=a->dyFmiSetBoolean(a->m, refs, nr, (fmiBoolean*)(dummy));
  }
  if (status!=fmiOK && status!=fmiWarning) ModelicaError(\"SetBoolean failed\");
}
#endif", Library="E", LibraryDirectory="modelica://Buildings/Resources/Library/FMU/E/binaries",
                                                                                            __Dymola_doNotLinkSharedObject=true);
    end fmiSetBoolean;

    function noHysteresis
      input Real x;
      output Real y;
    algorithm
      y:=x+(if (x < 0) then -1 else 1);
    end noHysteresis;
end fmi_Functions;
equation
  when initial() then
    fmi = fmi_Functions.fmiModel(fmi_instanceName, fmi_loggingOn, fmi_fmuLocation);
  end when;
algorithm
  when {initial(), sample(0, fmi_CommunicationStepSize)} then
    sorting1:=true;
  P_0Lights_01 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10001,
      fmi_Initialized);
  P_0Equip_01 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10002,
      fmi_Initialized);
  P_0Lights_02 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10003,
      fmi_Initialized);
  P_0Equip_02 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10004,
      fmi_Initialized);
  P_0Lights_03 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10005,
      fmi_Initialized);
  P_0Equip_03 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10006,
      fmi_Initialized);
  P_0Lights_04 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10007,
      fmi_Initialized);
  P_0Equip_04 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10008,
      fmi_Initialized);
  P_0Lights_05 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10009,
      fmi_Initialized);
  P_0Equip_05 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10010,
      fmi_Initialized);
  P_0Lights_06 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10011,
      fmi_Initialized);
  P_0Equip_06 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10012,
      fmi_Initialized);
  P_0Lights_07 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10013,
      fmi_Initialized);
  P_0Equip_07 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10014,
      fmi_Initialized);
  P_0Lights_08 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10015,
      fmi_Initialized);
  P_0Equip_08 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10016,
      fmi_Initialized);
  P_0Lights_09 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10017,
      fmi_Initialized);
  P_0Equip_09 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10018,
      fmi_Initialized);
  P_0Lights_010 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10019,
      fmi_Initialized);
  P_0Equip_010 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10020,
      fmi_Initialized);
  P_0Lights_011 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10021,
      fmi_Initialized);
  P_0Equip_011 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10022,
      fmi_Initialized);
  P_0Lights_012 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10023,
      fmi_Initialized);
  P_0Equip_012 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10024,
      fmi_Initialized);
  P_0Lights_013 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10025,
      fmi_Initialized);
  P_0Equip_013 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10026,
      fmi_Initialized);
  P_0Lights_014 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10027,
      fmi_Initialized);
  P_0Equip_014 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10028,
      fmi_Initialized);
  P_0Lights_015 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10029,
      fmi_Initialized);
  P_0Equip_015 :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10030,
      fmi_Initialized);
  P_0Tot_0El_0Demand :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10031,
      fmi_Initialized);
  P_0Fan :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10032,
      fmi_Initialized);
  E_0Vav_0tot_0Coo :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10033,
      fmi_Initialized);
  E_0Vav_0tot_0Hea :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10034,
      fmi_Initialized);
  E_0Vav_0gas_0Hea :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10035,
      fmi_Initialized);
  E_0Vav_0DX_0Hea :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10036,
      fmi_Initialized);
  E_0Vav_0DX_0Coo :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10037,
      fmi_Initialized);
  outTSetHea :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10038,
      fmi_Initialized);
  outTSetCoo :=fmi_Functions.fmiGetRealScalar(
      fmi,
      10039,
      fmi_Initialized);
  end when;
algorithm
  when sample(0, fmi_CommunicationStepSize) then
  fmi_Functions.fmiSetReal(fmi, {1}, {TSetHea}, 1);
  fmi_Functions.fmiSetReal(fmi, {2}, {TSetCoo}, 1);
    fmi_StepOK :=fmi_Functions.fmiDoStep(
      fmi,
      time,
      fmi_CommunicationStepSize,
      1);
    sorting2 :=sorting1;
  end when;
initial algorithm
  fmi_AParamsAndStart:=1;
 // 0Real parameters
 // 0Real start values
 // 0Integer parameters
 // 0Integer startValues
 // 0Boolean parameters
 // 0Boolean startvalues
 // 0Enumeration parameters
 // 0Enumeration startValues
initial equation
if fmi_pullInputsForInitialization then fmi_initInput0 = fmi_Functions.fmiSetReal(fmi, {1}, {TSetHea}, 1); else fmi_initInput0 = fmi_Functions.fmiSetReal(fmi, {1}, {_TSetHea_start}, 1); end if;
if fmi_pullInputsForInitialization then fmi_initInput1 = fmi_Functions.fmiSetReal(fmi, {2}, {TSetCoo}, 1); else fmi_initInput1 = fmi_Functions.fmiSetReal(fmi, {2}, {_TSetCoo_start}, 1); end if;
  fmi_Initialized = fmi_Functions.fmiInitializeSlave(fmi, fmi_StartTime, fmi_forceShutDownAtStopTime, fmi_StopTime,fmi_AParamsAndStart+ fmi_initInput0+ fmi_initInput1);

  annotation (
    Icon(graphics={
      Rectangle(
        extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5),
        Text(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-80,-72},{80,-94}},
          lineColor={95,95,95},
          textString="FMI import")}));
end E_fmu;