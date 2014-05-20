within Buildings.Controls.DemandResponse.BaseClasses;
block BaselineComputation "Computes the baseline consumption"
  extends Buildings.Controls.DemandResponse.BaseClasses.PartialDemandResponse;

  Buildings.Controls.Interfaces.DayTypeInput typeOfDay
    "If true, this day remains an event day until midnight" annotation (
      Placement(transformation(extent={{-120,90},{-100,70}}),
        iconTransformation(extent={{-120,90},{-100,70}})));

  Modelica.Blocks.Interfaces.BooleanInput isEventDay
    "If true, this day remains an event day until midnight"
    annotation (Placement(transformation(extent={{-120,50},{-100,30}}),
        iconTransformation(extent={{-120,50},{-100,30}})));
  parameter Integer nHis(min=1) = 3 "Number of history terms to be stored";
  discrete Modelica.SIunits.Power P[Types.nDayTypes, nSam, nHis]
    "Baseline power consumption";
  Modelica.SIunits.Energy E "Consumed energy since last sample";

protected
  Modelica.SIunits.Time tLast "Time at which last sample occured";
  Integer iSam "Index for power of the current sampling interval";
  Integer iHis[Types.nDayTypes]
    "Index for power of the current sampling history, for the currrent time interval";
  Boolean historyComplete[Types.nDayTypes]
    "Flage, set to true when all history terms are built up for the given day type";
  Boolean firstCall "Set to true after first call";
initial equation
   P = zeros(Types.nDayTypes, nSam, nHis);
   iSam = 1;
   iHis = ones(Types.nDayTypes);
   for i in 1:Types.nDayTypes loop
     historyComplete[i] = false;
   end for;
   firstCall = true;
equation
  der(E) = PCon;
  PPre = P[typeOfDay, iSam, iHis[typeOfDay]];

algorithm
  when localActive then
    // Shift power consumption by one time unit
    if iSam == nSam then
      iSam := 1;
      if iHis[typeOfDay] == nHis then
        iHis[typeOfDay] := 1;
        historyComplete[typeOfDay] := true;
      else
        iHis[typeOfDay] :=iHis[typeOfDay] + 1;
        historyComplete[typeOfDay] :=historyComplete[typeOfDay];
      end if;
    else
      iSam := if pre(firstCall) then iSam else iSam + 1;
      iHis[typeOfDay] := iHis[typeOfDay];
      historyComplete[typeOfDay] :=historyComplete[typeOfDay];
    end if;
    firstCall :=false;
    // Update the history terms with the average power of the time interval.
    P[pre(typeOfDay), pre(iSam), pre(iHis[typeOfDay])] := if (time-pre(tLast)) < 1E-5 then 0 else pre(E)/(time - pre(tLast));
    // Initialized the energy consumed since the last sampling
    reinit(E, 0);
    tLast :=time;
  end when;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={Text(
          extent={{-70,64},{74,-54}},
          lineColor={0,0,255},
          textString="BL")}),
    Documentation(info="<html>
<p>
Block that computes the baseline for a demand response client.
This implementation computes the 10/10 average baseline.
This baseline is the average of the consumed power of the previous
10 days for the same time interval. For example, if the base line is
computed every 1 hour. Then there are 24 baseline values for each day.
Separate baselines are computed for these days:
</p>
<ul>
<li>
Weekdays.
</li>
<li>
Weekends and holidays.
</li>
</ul>
<p>
If a day is an event day, then this day is excluded from the baseline computation.
</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end BaselineComputation;
