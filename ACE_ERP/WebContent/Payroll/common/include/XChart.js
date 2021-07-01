/*

XChart를 초기화(XChart에 대한 프로퍼티 설정을 한다.)

변수
 oXChart : 초기화 하고자하는 XChart

*/

function cfInitXChart1(oXChart) {

	//먼저 기존의 Series들을 클리어 한다
	oXChart.RemoveAllSeries();

	//XChart의 보기,기울기등의 속성을 설정한다
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 10;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart의 타이틀에 관련된 속성을 설정한다
  //주의 : XChart에는 Title속성이 없고 대신 Header속성이 존재한다
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart의 판넬의 속성을 설정한다
	//XChart가 표시되는 전체영역의 바탕을 설정하는것이다
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart의 좌표축에 관련된 속성을 설정한다

	//XChart의 각축의 벽에 색을 지정한다
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//축을 나타내는 선에 대해 설정한다
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//축에 표시되는 좌표값의 색을 지정한다
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend의 속성을 설정한다

	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 0;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 100;
	oXChart.Legend.Alignment = 2;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 0;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

/*
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 150;
	oXChart.Legend.Alignment = 2;	//범례의 위치
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 1;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");
	oXChart.Legend.FontSeriesColor = true;
*/
/*
		oXChart.Legend.Visible = 1;
		oXChart.Legend.Symbol.Width = 100;
		oXChart.Legend.Alignment = 2;
		oXChart.Legend.Font.Size = 9;
		oXChart.Legend.ShadowSize = 0;
   oXChart.Legend.Frame.Visible = true;
*/

	//툴팁(마우스를 Series위에 올렸을때 값을 보여 주기위한 설정
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//한 page에 들어가는 Point수를 정의한다.
	 oXChart.Page.MaxPointsPerPage = 5;
}

function cfInitXChart2(oXChart) {

	//먼저 기존의 Series들을 클리어 한다
	oXChart.RemoveAllSeries();

	//XChart의 보기,기울기등의 속성을 설정한다
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 15;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart의 타이틀에 관련된 속성을 설정한다
  //주의 : XChart에는 Title속성이 없고 대신 Header속성이 존재한다
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart의 판넬의 속성을 설정한다
	//XChart가 표시되는 전체영역의 바탕을 설정하는것이다
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart의 좌표축에 관련된 속성을 설정한다

	//XChart의 각축의 벽에 색을 지정한다
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//축을 나타내는 선에 대해 설정한다
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//축에 표시되는 좌표값의 색을 지정한다
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend의 속성을 설정한다
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//툴팁(마우스를 Series위에 올렸을때 값을 보여 주기위한 설정
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//한 page에 들어가는 Point수를 정의한다.
	 oXChart.Page.MaxPointsPerPage = 15;
}

function cfInitXChart3(oXChart) {

	//먼저 기존의 Series들을 클리어 한다
	oXChart.RemoveAllSeries();

	//XChart의 보기,기울기등의 속성을 설정한다
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 15;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart의 타이틀에 관련된 속성을 설정한다
  //주의 : XChart에는 Title속성이 없고 대신 Header속성이 존재한다
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart의 판넬의 속성을 설정한다
	//XChart가 표시되는 전체영역의 바탕을 설정하는것이다
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart의 좌표축에 관련된 속성을 설정한다

	//XChart의 각축의 벽에 색을 지정한다
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//축을 나타내는 선에 대해 설정한다
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//축에 표시되는 좌표값의 색을 지정한다
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend의 속성을 설정한다
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//툴팁(마우스를 Series위에 올렸을때 값을 보여 주기위한 설정
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//한 page에 들어가는 Point수를 정의한다.
	 oXChart.Page.MaxPointsPerPage = 10;
}

function cfInitXChart12(oXChart) {

	//먼저 기존의 Series들을 클리어 한다
	oXChart.RemoveAllSeries();

	//XChart의 보기,기울기등의 속성을 설정한다
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 15;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart의 타이틀에 관련된 속성을 설정한다
  //주의 : XChart에는 Title속성이 없고 대신 Header속성이 존재한다
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart의 판넬의 속성을 설정한다
	//XChart가 표시되는 전체영역의 바탕을 설정하는것이다
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart의 좌표축에 관련된 속성을 설정한다

	//XChart의 각축의 벽에 색을 지정한다
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//축을 나타내는 선에 대해 설정한다
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//축에 표시되는 좌표값의 색을 지정한다
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend의 속성을 설정한다
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//툴팁(마우스를 Series위에 올렸을때 값을 보여 주기위한 설정
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//한 page에 들어가는 Point수를 정의한다.
	 oXChart.Page.MaxPointsPerPage = 13;
}

function cfInitXChart33(oXChart) {

	//먼저 기존의 Series들을 클리어 한다
	oXChart.RemoveAllSeries();

	//XChart의 보기,기울기등의 속성을 설정한다
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 15;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart의 타이틀에 관련된 속성을 설정한다
  //주의 : XChart에는 Title속성이 없고 대신 Header속성이 존재한다
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart의 판넬의 속성을 설정한다
	//XChart가 표시되는 전체영역의 바탕을 설정하는것이다
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart의 좌표축에 관련된 속성을 설정한다

	//XChart의 각축의 벽에 색을 지정한다
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//축을 나타내는 선에 대해 설정한다
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//축에 표시되는 좌표값의 색을 지정한다
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend의 속성을 설정한다
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//툴팁(마우스를 Series위에 올렸을때 값을 보여 주기위한 설정
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//한 page에 들어가는 Point수를 정의한다.
	 oXChart.Page.MaxPointsPerPage = 13;

	// 각 축의 title
	oXChart.Axis.Left.Title.Visible = true;
	oXChart.Axis.Left.Title.Caption = "(단위 :  명)";
	oXChart.Axis.Bottom.Title.Caption = "(단위 : 만원대)";

}

function cfInitXChart4(oXChart) {

	//먼저 기존의 Series들을 클리어 한다
	oXChart.RemoveAllSeries();

	//XChart의 보기,기울기등의 속성을 설정한다
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 15;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart의 타이틀에 관련된 속성을 설정한다
  //주의 : XChart에는 Title속성이 없고 대신 Header속성이 존재한다
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=11;
	oXChart.Header.Text.Add ('');

	//XChart의 판넬의 속성을 설정한다
	//XChart가 표시되는 전체영역의 바탕을 설정하는것이다
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart의 좌표축에 관련된 속성을 설정한다

	//XChart의 각축의 벽에 색을 지정한다
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//축을 나타내는 선에 대해 설정한다
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//축에 표시되는 좌표값의 색을 지정한다
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend의 속성을 설정한다
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//툴팁(마우스를 Series위에 올렸을때 값을 보여 주기위한 설정
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//한 page에 들어가는 Point수를 정의한다.
	 oXChart.Page.MaxPointsPerPage = 13;

	// 각 축의 title
	oXChart.Axis.Left.Title.Visible = true;
	oXChart.Axis.Left.Title.Caption = "(단위 :  명)";
	oXChart.Axis.Bottom.Title.Caption = "(단위 : 천포인트)";

}

function cfInitXChart13(oXChart) {
	//먼저 기존의 Series들을 클리어 한다
	oXChart.RemoveAllSeries();

	//XChart의 보기,기울기등의 속성을 설정한다
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 20;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart의 타이틀에 관련된 속성을 설정한다
  //주의 : XChart에는 Title속성이 없고 대신 Header속성이 존재한다
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=9;
	oXChart.Header.Text.Add ('부서별 현황');

	//XChart의 판넬의 속성을 설정한다
	//XChart가 표시되는 전체영역의 바탕을 설정하는것이다
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart의 좌표축에 관련된 속성을 설정한다

	//XChart의 각축의 벽에 색을 지정한다
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//축을 나타내는 선에 대해 설정한다
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = true;
	oXChart.Axis.Right.GridPen.visible = false;

	//축에 표시되는 좌표값의 색을 지정한다
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend의 속성을 설정한다
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = false;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//툴팁(마우스를 Series위에 올렸을때 값을 보여 주기위한 설정
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//한 page에 들어가는 Point수를 정의한다.
	 //oXChart.Page.MaxPointsPerPage = 15;
	 oXChart.Page.MaxPointsPerPage = 40;

}

function cfInitXChart14(oXChart) {

	//먼저 기존의 Series들을 클리어 한다
	oXChart.RemoveAllSeries();

	//XChart의 보기,기울기등의 속성을 설정한다
	oXChart.Aspect.View3D = true;
	oXChart.Aspect.Chart3DPercent = 15;
	oXChart.Aspect.Elevation = 270;
	oXChart.Aspect.Zoom = 100;

  //Xchart의 타이틀에 관련된 속성을 설정한다
  //주의 : XChart에는 Title속성이 없고 대신 Header속성이 존재한다
	oXChart.Header.Alignment = 2;
	oXChart.Header.Text.Clear();
	oXChart.Header.Font.Size=9;
	oXChart.Header.Text.Add ('직종별 현황');
	
	//XChart의 판넬의 속성을 설정한다
	//XChart가 표시되는 전체영역의 바탕을 설정하는것이다
	oXChart.Panel.Color = oXChart.ToOLEColor("#ffffff");
	oXChart.Panel.BorderStyle = 0;

	//XChart의 좌표축에 관련된 속성을 설정한다

	//XChart의 각축의 벽에 색을 지정한다
	oXChart.Walls.Left.Color   = oXChart.ToOLEColor("YELLOW");
	oXChart.Walls.Right.Color  = oXChart.ToOLEColor("RED");
	oXChart.Walls.Bottom.Color = oXChart.ToOLEColor("BLUE");

	//축을 나타내는 선에 대해 설정한다
	oXChart.Axis.Bottom.GridPen.visible = false;
	oXChart.Axis.Left.GridPen.visible = false;
	oXChart.Axis.Right.GridPen.visible = false;

	//축에 표시되는 좌표값의 색을 지정한다
	oXChart.Axis.Left.Labels.Font.Color   = oXChart.ToOLEColor("BLUE");
	oXChart.Axis.Right.Labels.Font.Color  = oXChart.ToOLEColor("RED");
	oXChart.Axis.Bottom.Labels.Font.Color = oXChart.ToOLEColor("BLACK");

	//Legend의 속성을 설정한다
	oXChart.Legend.LegendStyle = 0;
	oXChart.Legend.TextStyle = 3;
	oXChart.Legend.CheckBoxes = true;
	oXChart.Legend.Symbol.Width = 20;
	oXChart.Legend.Alignment = 1;
	oXChart.Legend.Font.Size = 8.7;
	oXChart.Legend.TopPos = 5;
	oXChart.Legend.VertSpacing = 0;
	oXChart.Legend.ShadowSize = 5;
	oXChart.Legend.ShapeStyle = 1;
	oXChart.Legend.Color = oXChart.ToOLEColor("yellow");
	oXChart.Legend.ShadowColor = oXChart.ToOLEColor("green");

	//툴팁(마우스를 Series위에 올렸을때 값을 보여 주기위한 설정
	var Toolsidx = oXChart.Tools.Add(8);
	oXChart.Tools.Items(Toolsidx).asMarksTip.MouseAction = 0;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Style = 4;
	oXChart.Tools.Items(Toolsidx).asMarksTip.Delay = 0;

	//한 page에 들어가는 Point수를 정의한다.
	 oXChart.Page.MaxPointsPerPage = 2;
}

/*

실제 Series를 하나씩 추가

변수
	oXChart : 추가하고자 하는 XChart Object
	oDataSet : XChart에 지정하는 DataID, 즉 데이타셋
	vType : Series의 종류를 지정한다
	vTitle : Legend에 표시되는 이름
	vLable : X축에 표시되는 이름
	vYvalue : 차트에 적욛되는 실제의 값
	vColor : 해당 Series에 적용하는 색상

*/

function cfInitXChart15(XChart) {

	//Chart 3d로 표현할지 여부
	XChart.Aspect.View3D="true";
	
	//Chart 배경색과 borderstyle
	XChart.Panel.Color = XChart.ToOLEColor("white");
	XChart.Panel.BorderStyle = 0;
	
	//Header관련
	XChart.Header.Font.Color = XChart.ToOLEColor("BLUE");
	XChart.Header.Text.Clear();
	XChart.Header.Text.Add ("직종별 현황");
	XChart.Header.Alignment = 2;

	//legend관련
	XChart.Legend.ShadowSize = 0;
	XChart.Legend.Frame.Visible = false;
	XChart.Legend.TopPos = 45;
	XChart.Legend.Alignment = 2;
	XChart.Legend.Symbol.WidthUnits = 1;
	XChart.Legend.Symbol.Width = 20;

	//Grid없앰.
	//XChart.Axis.Bottom.GridPen.visible = false;
	//XChart.Axis.Left.GridPen.visible = false;
	XChart.Axis.Left.Labels.Font.Color   = XChart.ToOLEColor("BLUE");

	//MarkTip 관련 (마우스 click하여 값을 확인할 수 있다.)
	Mark = XChart.Tools.Add (8);
	
	XChart.Tools.Items(Mark).asMarksTip.Series = "0"; // Uses Seriesindex
	XChart.Tools.Items(Mark).asMarksTip.style = 0;
	XChart.Tools.Items(Mark).asMarksTip.MouseAction = 0;  //0:mouse over, 1:mouse click
	XChart.Tools.Items(Mark).asMarksTip.Delay = 0;
	
	XChart.Zoom.Pen.Color = XChart.ToOLEColor("#1D5B89");
}


function cfAddSeriesOne_1(oXChart,nDataSet,vType,vTitle,vColor,cLabel,cYvalue) {

	if ((vTitle == null)||(vTitle == "undefined")) return;

	//Series를 추가한다
	var idx = oXChart.AddSeries(vType);

	//oXChart.Axis.Bottom.Labels.Angle = -45;
	oXChart.Axis.Bottom.Labels.MultiLine = true;

    oXChart.Series(idx).ShowInLegend = false;

	//Series의 종류와 상관없이 주는 속성들이다
	oXChart.Series(idx).DataID = nDataSet;
	oXChart.Series(idx).Title = vTitle;
	oXChart.Series(idx).LabelColumn = cLabel;
	oXChart.Series(idx).color = oXChart.ToOLEColor(vColor);
	oXChart.Series(idx).YValueColumn = cYvalue;
	oXChart.Series(idx).Marks.visible = true;

	//각각의 막대그래프의 색을 달리 주는 속성.
	oXChart.Series(idx).ColorEachPoint = true;
//	oXChart.Series(idx).ColorEachPoint = true;
	//각각의 막대그래프끝에 데이타값이 찍히게 하는 속성.
	oXChart.Series(idx).Marks.Style =0;


	//Series의 종류별로 다른 속성들을 준다

		if (vType == 31) {
		oXChart.Series(idx).asBarJoin.MultiBar="2";
		oXChart.Series(idx).asBarJoin.JoinPen.visible=false;
		}

/*
	if (vType == 0) {
		oXChart.Series(idx).VerticalAxis = 1;
		oXChart.Series(idx).asLine.Stacked = 1;
		oXChart.Series(idx).Depth = 5;
	}

  else if (vType == 31) {
		oXChart.Series(idx).asBarJoin.MultiBar="2";
		oXChart.Series(idx).asBarJoin.JoinPen.visible=false;
  }
*/
  oXChart.reset();

}

function cfAddSeriesOne_2(oXChart,nDataSet,vType,vTitle,vColor,cLabel,cYvalue) {

	if ((vTitle == null)||(vTitle == "undefined")) return;

	oXChart.RemoveAllSeries();
	//Series를 추가한다
	var idx = oXChart.AddSeries(vType);

	//oXChart.Axis.Bottom.Labels.Angle = -45;
	oXChart.Axis.Bottom.Labels.MultiLine = true;

    oXChart.Series(idx).ShowInLegend = false;

	//Series의 종류와 상관없이 주는 속성들이다
	oXChart.Series(idx).DataID = nDataSet;
	oXChart.Series(idx).Title = vTitle;
	oXChart.Series(idx).LabelColumn = cLabel;
	oXChart.Series(idx).color = oXChart.ToOLEColor(vColor);
	oXChart.Series(idx).YValueColumn = cYvalue;
	oXChart.Series(idx).Marks.visible = true;


	//각각의 막대그래프의 색을 달리 주는 속성.
	oXChart.Series(idx).ColorEachPoint = true;
//	oXChart.Series(idx).ColorEachPoint = true;
	//각각의 막대그래프끝에 데이타값이 찍히게 하는 속성.
	oXChart.Series(idx).Marks.Style =1;

	//Series의 종류별로 다른 속성들을 준다
	if (vType == 31) {
		oXChart.Series(idx).asBarJoin.MultiBar="2";
		oXChart.Series(idx).asBarJoin.JoinPen.visible=false;
	}

  oXChart.reset();

}

