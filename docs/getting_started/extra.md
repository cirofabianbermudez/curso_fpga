# Extra

``` mermaid
%%{ 
  init : { 
    "theme" : "default", 
    "flowchart" : { 
      "curve" : "linear" 
    }
  }
}%%
graph TB
  A[Digital Logic];
  B[Standard Logic];
  C[Programable Logic];
  D[ASICs];
  E[Full Custom];

  F["TTL 
     74xx"];
  G["CMOS
     4xxx"];

  H[PLDs];
  I[FPGAs];
  J[CPLDs];

  K["Gate 
     Arrays"];
  L["Standard 
     Cell"];

  M["Microprocessor
     & ARM"];


  A --> B;
  A --> C;
  A --> D;
  A --> E;

  B --> F;
  B --> G;

  C --> H;
  C --> I;
  C --> J;

  D --> K;
  D --> L;

  E --> M;
```


``` mermaid
%%{ 
  init : { 
    "theme" : "default", 
    "flowchart" : { 
      "curve" : "linear" 
    }
  }
}%%
graph LR
  A["Design Entry:
     Schematic or 
     HDL"];
  B["Functional 
     Simulation"];
  C["Synthesis or
     Mapping"];
  D["Place and Route
     or Fitting"];
  E["Simulation"];
  F["Programming"];
  G["Test and 
      Integration"];
  H["Release"];
  
  A --> B;
  B --> C;
  
  B --> A;
  
  C --> D;
  D --> E;
  E --> F;
  
  E --> B;
  
  F --> G;
  
  G --> E;
  
  G --> H; 
```



## Quartus Prime

### Design Entry
- Schematic Capture
- Import of IP blocks
- HDL text entry, including VHDL, Verilog, and System Verilg
- State machine entry
- Import of EDIF files


### Design Analysis ans Synthesis
- Checks the design source files for errors
- Builds a database
- Synthesizes and optimizes the logic design
- Maps the design logic to device resources

### Design Fitting
- Balanced
- High Perfomance (Speed)
- Low Power
- Small Area


### Design Analysis in Picture
- RTL Viewer
- Technology Map Viewer
- Chip Planner

### Simulation
- Static Timing Analysis
- TimeQuest timing analyzer
    - Calculate slack
    - Determine Fmax
- ModelSim