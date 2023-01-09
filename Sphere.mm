-(void)DrawDebugSphere: (Vector)Center Radius: (float)Radius Segments: (int)NumSegments ViewMatrix: (float*)ViewMatrix
{
  int Segments = NumSegments >= 4 ? NumSegments : 4;

  Vector Vertex1, Vertex2, Vertex3, Vertex4;
  const float AngleInc = 2.f * PI / float(Segments);
  int NumSegmentsY = Segments;
  float Latitude = AngleInc;
  int NumSegmentsX;
  float Longitude;
  float SinY1 = 0.0f, CosY1 = 1.0f, SinY2, CosY2;
  float SinX, CosX;
  while( NumSegmentsY-- )
  {
    SinY2 = sin(Latitude);
    CosY2 = cos(Latitude);

    Vertex1 = {SinY1 * Radius + Center.X, Center.Y, CosY1 * Radius + Center.Z};
    Vertex3 = {SinY2 * Radius + Center.X, Center.Y, CosY2 * Radius + Center.Z};

    Longitude = AngleInc;
    NumSegmentsX = Segments;
    while( NumSegmentsX-- )
    {
      SinX = sin(Longitude);
      CosX = cos(Longitude);

      Vertex2 = {(CosX * SinY1 * Radius) + Center.X, (SinX * SinY1*Radius) + Center.Y, (CosY1*Radius)+Center.Z}; // multiply them all by radius
      Vertex4 = {(CosX * SinY2 * Radius) + Center.X, (SinX * SinY2*Radius) + Center.Y, (CosY2*Radius)+Center.Z}; //multiply them all by radius
      Vector Vertex1ScreenLocation = world2Screen(Vertex1, ViewMatrix);
      Vector Vertex2ScreenLocation = world2Screen(Vertex2, ViewMatrix);
      Vector Vertex3ScreenLocation = world2Screen(Vertex3, ViewMatrix);
      [self drawLineWithStartPoint:ImVec2(Vertex1ScreenLocation.X, Vertex1ScreenLocation.Y) endPoint:ImVec2(Vertex2ScreenLocation.X, Vertex2ScreenLocation.Y) color:Color::Green thicknes:1.0f];
      [self drawLineWithStartPoint:ImVec2(Vertex1ScreenLocation.X, Vertex1ScreenLocation.Y) endPoint:ImVec2(Vertex3ScreenLocation.X, Vertex3ScreenLocation.Y) color:Color::Green thicknes:1.0f];
      Vertex1 = Vertex2;
      Vertex3 = Vertex4;
      Longitude += AngleInc;
    }
    SinY1 = SinY2;
    CosY1 = CosY2;
    Latitude += AngleInc;
  }
}