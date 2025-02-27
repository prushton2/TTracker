import 'package:flutter/material.dart';


class Stop {
  String address = "";
  double latitude = 0;
  double longitude = 0;
  int wheelchair_boarding = -1;
  String id = "";
  String name = "";
  double distance = -1;

  Stop(String _address, double _latitude, double _longitude, int _wheelchair_boarding, String _id, String _name) {
    address  = _address;
    latitude = _latitude;
    longitude = _longitude;
    wheelchair_boarding = _wheelchair_boarding;
    id = _id;
    name = _name;
  }
}

Stop? selectedStop = null;

Widget renderStopInfo() {
  return Row(children: []);
}

class SelectStop extends StatefulWidget {
  const SelectStop({super.key, required this.title});
  final String title;

  @override
  State<SelectStop> createState() => SelectStopState();
}

class SelectStopState extends State<SelectStop> {
  double buttonDistance = 2;

  List<Row> RenderStopNames() {

    List<Row> textboxes = [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => {
              setState(() => selectedStop = null)
            },
            style: TextButton.styleFrom(
                fixedSize: Size(MediaQuery.sizeOf(context).width/3, 100),
                backgroundColor: Colors.black38,
                shape: const ContinuousRectangleBorder(),
                overlayColor: Colors.white
            ),
            child: const Text("Auto Detect", style: TextStyle(color: Colors.white)),
          )
        ],
      )
    ];


    int counter = 1;
    for(String key in stopInfo.keys) {
      Stop value = stopInfo[key]!;

      TextButton button = TextButton(
        onPressed: () => {setState(() => selectedStop = stopInfo[key])},
        style: TextButton.styleFrom(
            fixedSize: Size(MediaQuery.sizeOf(context).width/3, 100),
            backgroundColor: Colors.black38,
            shape: const ContinuousRectangleBorder(),
            overlayColor: Colors.white
        ),
        child: Text(value.name, style: const TextStyle(color: Colors.white)),
      );

      if(counter%2==0) {
        textboxes.add(
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [button])
        );
      } else {
        textboxes.last.children.add(SizedBox(width: buttonDistance));
        textboxes.last.children.add(button);
      }
      counter++;
    }
    return textboxes;
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold (
        body: Column (
            children: <Widget> [
              Text("Current Stop: "+ (selectedStop == null ? "Auto Detect" : selectedStop!.name)),
              Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: RenderStopNames(),
                  )
              ),
            ]
        )
    );
  }
}


Map<String, Stop> stopInfo = {
  "place-PB-0194": Stop("231 Centre Ave, Abington, MA 02351", 42.107156, -70.934405, 0, "place-PB-0194", "Abington"),
  "place-aport": Stop("Transportation Way and Service Rd, Boston, MA 02128", 42.374262, -71.030395, 0, "place-aport", "Airport"),
  "place-alfcl": Stop("Alewife Brook Pkwy and Cambridge Park Dr, Cambridge, MA 02140", 42.39583, -71.141287, 0, "place-alfcl", "Alewife"),
  "place-alsgr": Stop("Allston St and Commonwealth Ave, Boston, MA 02134", 42.348701, -71.137955, 0, "place-alsgr", "Allston Street"),
  "place-amory": Stop("Commonwealth Ave and Amory St, Boston, MA 02215", 42.350992, -71.114748, 0, "place-amory", "Amory Street"),
  "place-NHRML-0127": Stop("100 Atlantic Ave, Woburn, MA 01801", 42.516987, -71.144475, 0, "place-NHRML-0127", "Anderson/Woburn"),
  "place-WR-0228": Stop("17 Railroad St, Andover, MA 01810", 42.658336, -71.144502, 0, "place-WR-0228", "Andover"),
  "place-andrw": Stop("Dorchester Ave and Southhampton St, South Boston, MA 02127", 42.330154, -71.057655, 0, "place-andrw", "Andrew"),
  "place-aqucl": Stop("Atlantic Ave and State St, Boston, MA 02120", 42.359784, -71.051652, 0, "place-aqucl", "Aquarium"),
  "place-armnl": Stop("Arlington St and Boylston St, Boston, MA 02116", 42.351902, -71.070893, 0, "place-armnl", "Arlington"),
  "place-WML-0252": Stop("Pleasant St and Cordaville Rd, Ashland, MA 01721", 42.26149, -71.482161, 0, "place-WML-0252", "Ashland"),
  "place-asmnl": Stop("Dorchester Ave and Ashmont St, Boston, MA 02124", 42.28452, -71.063777, 0, "place-asmnl", "Ashmont"),
  "place-astao": Stop("499 Foley St, Somerville, MA 02145", 42.392811, -71.077257, 0, "place-astao", "Assembly"),
  "place-NEC-1969": Stop("133 South Main St, Attleboro, MA 02703", 41.940739, -71.285094, 0, "place-NEC-1969", "Attleboro"),
  "place-WML-0102": Stop("Auburn St and Woodland Rd, Newton, MA 02466", 42.345833, -71.250373, 0, "place-WML-0102", "Auburndale"),
  "place-FR-0361": Stop("70 Main St, Ayer, MA 01432", 42.559074, -71.588476, 0, "place-FR-0361", "Ayer"),
  "place-babck": Stop("Commonwealth Ave and Babcock St, Boston, MA 02215", 42.351616, -71.119924, 0, "place-babck", "Babcock Street"),
  "place-bbsta": Stop("145 Dartmouth St Boston, MA 02116", 42.34735, -71.075727, 0, "place-bbsta", "Back Bay"),
  "place-bckhl": Stop("100 South Huntington Ave, Boston, MA 02130", 42.330139, -71.111313, 0, "place-bckhl", "Back of the Hill"),
  "place-balsq": Stop("646 Boston Ave, Somerville, MA 02144", 42.399889, -71.111003, 0, "place-balsq", "Ball Square"),
  "place-WR-0205": Stop("195 Andover St, Andover, MA 01810", 42.627356, -71.159962, 0, "place-WR-0205", "Ballardvale"),
  "place-bmmnl": Stop("630 Winthrop Ave, Revere, MA 02151", 42.397542, -70.992319, 0, "place-bmmnl", "Beachmont"),
  "place-bcnfd": Stop("124 Beaconsfield Rd, Brookline, MA 02445", 42.335765, -71.140455, 0, "place-bcnfd", "Beaconsfield"),
  "place-NB-0072": Stop("35 Colbert St, West Roxbury, MA 02132", 42.286588, -71.145557, 0, "place-NB-0072", "Bellevue"),
  "place-belsq": Stop("None", 42.395438, -71.033884, 0, "place-belsq", "Bellingham Square"),
  "place-FR-0064": Stop("Common St and Concord Ave, Belmont, MA 02478", 42.395896, -71.17619, 0, "place-FR-0064", "Belmont"),
  "place-ER-0183": Stop("10 Park St, Beverly, MA 01915", 42.547276, -70.885432, 0, "place-ER-0183", "Beverly"),
  "place-GB-0229": Stop("1 Oak St, Beverly, MA 01915", 42.561651, -70.811405, 0, "place-GB-0229", "Beverly Farms"),
  "place-bland": Stop("Commonwealth Ave and Blandford Mall, Boston, MA 02215", 42.349293, -71.100258, 0, "place-bland", "Blandford Street"),
  "place-DB-2222": Stop("Blue Hill Ave or Cummins Hwy at Woodhaven St, Mattapan, MA 02126", 42.271466, -71.095782, 0, "place-DB-2222", "Blue Hill Avenue"),
  "place-lake": Stop("Commonwealth Ave and Lake St, Boston, MA 02135", 42.340081, -71.166769, 0, "place-lake", "Boston College"),
  "place-WML-0035": Stop("100 Arthur St, Boston, MA 02134", 42.357293, -71.139883, 0, "place-WML-0035", "Boston Landing"),
  "place-bucen": Stop("Commonwealth Ave and Marsh Chapel, Boston, MA 02215", 42.350082, -71.106865, 0, "place-bucen", "Boston University Central"),
  "place-buest": Stop("Commonwealth Ave and Granby St, Boston, MA 02215", 42.349735, -71.103889, 0, "place-buest", "Boston University East"),
  "place-CM-0564": Stop("21 Bourne Bridge, Bourne, MA 02532", 41.746497, -70.588772, 0, "place-CM-0564", "Bourne"),
  "place-bomnl": Stop("Cambridge St and New Chardon St, Boston, MA 02114", 42.361365, -71.062037, 0, "place-bomnl", "Bowdoin"),
  "place-boxdt": Stop("None", 42.394049, -71.028365, 0, "place-boxdt", "Box District"),
  "place-boyls": Stop("Boylston St and Tremont St, Boston, MA", 42.35302, -71.06459, 0, "place-boyls", "Boylston"),
  "place-WR-0325": Stop("10 Railroad Ave, Bradford, MA 01835", 42.766912, -71.088411, 0, "place-WR-0325", "Bradford"),
  "place-brntn": Stop("197 Ivory St, Braintree, MA 02184", 42.207854, -71.001138, 0, "place-brntn", "Braintree"),
  "place-FR-0115": Stop("1 Sawyer Rd, Waltham, MA 02453", 42.361898, -71.260065, 0, "place-FR-0115", "Brandeis/Roberts"),
  "place-bndhl": Stop("1481 Beacon St, Brookline, MA", 42.340023, -71.129082, 0, "place-bndhl", "Brandon Hall"),
  "place-MM-0277": Stop("85 Burrill Ave, Bridgewater, MA 02324", 41.984916, -70.96537, 0, "place-MM-0277", "Bridgewater"),
  "place-brmnl": Stop("Huntington Ave and Francis St, Boston, MA", 42.334229, -71.104609, 0, "place-brmnl", "Brigham Circle"),
  "place-brdwy": Stop("Dorchester Ave and Broadway, Boston, MA", 42.342622, -71.056967, 0, "place-brdwy", "Broadway"),
  "place-MM-0200": Stop("7 Commercial St, Brockton, MA 02302", 42.084659, -71.016534, 0, "place-MM-0200", "Brockton"),
  "place-brkhl": Stop("Tappan St and Cypress St, Brookline, MA 02445", 42.331316, -71.126683, 0, "place-brkhl", "Brookline Hills"),
  "place-bvmnl": Stop("31 Station St, Brookline, MA 02445", 42.332608, -71.116857, 0, "place-bvmnl", "Brookline Village"),
  "place-butlr": Stop("Butler St and Branchfield St, Dorchester, MA 02124", 42.272429, -71.062519, 0, "place-butlr", "Butler"),
  "place-CM-0547": Stop("70 Main Street, Buzzards Bay, MA 02532", 41.744805, -70.616226, 0, "place-CM-0547", "Buzzards Bay"),
  "place-MM-0219": Stop("30 Riverside Ave, Brockton, MA 02301", 42.060951, -71.011004, 0, "place-MM-0219", "Campello"),
  "place-SB-0156": Stop("710 Washington St, Canton, MA 02021", 42.157095, -71.14628, 0, "place-SB-0156", "Canton Center"),
  "place-NEC-2139": Stop("Beaumont St and Sherman St, Canton, MA 02021", 42.163204, -71.15376, 0, "place-NEC-2139", "Canton Junction"),
  "place-capst": Stop("50 Capen St, Milton, MA 02186", 42.267563, -71.087338, 0, "place-capst", "Capen Street"),
  "place-cedgr": Stop("Fellsway St and Milton St, Dorchester, MA 02124", 42.279629, -71.060394, 0, "place-cedgr", "Cedar Grove"),
  "place-cntsq": Stop("Massachusetts Ave and Prospect St, Cambridge, MA 02139", 42.365486, -71.103802, 0, "place-cntsq", "Central"),
  "place-cenav": Stop("23 Central Ave, Milton, MA 02186", 42.270027, -71.073444, 0, "place-cenav", "Central Avenue"),
  "place-chmnl": Stop("Cambridge St and Charles St, Boston, MA", 42.361166, -71.070628, 0, "place-chmnl", "Charles/MGH"),
  "place-chels": Stop("174 Everett Ave, Chelsea, MA 02150", 42.397024, -71.041314, 0, "place-chels", "Chelsea"),
  "place-chhil": Stop("Hammond St and Chestnut Hill Rd, Newton, MA 02467", 42.326753, -71.164699, 0, "place-chhil", "Chestnut Hill"),
  "place-chill": Stop("Commonwealth Ave and Chestnut Hill Ave, Boston, MA", 42.338169, -71.15316, 0, "place-chill", "Chestnut Hill Avenue"),
  "place-chncl": Stop("Washington St and Boylston St, Boston, MA", 42.352547, -71.062752, 0, "place-chncl", "Chinatown"),
  "place-chswk": Stop("Commonwealth Ave and Chiswick Rd, Boston, MA", 42.340805, -71.150711, 0, "place-chswk", "Chiswick Road"),
  "place-clmnl": Stop("Beacon St and Chestnut Hill Ave, Brighton, MA", 42.336142, -71.149326, 0, "place-clmnl", "Cleveland Circle"),
  "place-GRB-0199": Stop("110 Chief Justice Cushing Hwy, Cohasset, MA 02025", 42.24421, -70.837529, 0, "place-GRB-0199", "Cohasset"),
  "place-ccmnl": Stop("Austin St and Rutherford Ave, Charlestown, MA", 42.373622, -71.069533, 0, "place-ccmnl", "Community College"),
  "place-FR-0201": Stop("90 Thoreau St, Concord, MA 01742", 42.456565, -71.357677, 0, "place-FR-0201", "Concord"),
  "place-cool": Stop("Beacon St and Harvard St, Brookline, MA", 42.342116, -71.121263, 0, "place-cool", "Coolidge Corner"),
  "place-coecl": Stop("Boylston St and Dartmouth St, Boston, MA", 42.349974, -71.077447, 0, "place-coecl", "Copley"),
  "place-crtst": Stop("Seaport Blvd and Pittsburg St, Boston, MA", 42.35245, -71.04685, 0, "place-crtst", "Courthouse"),
  "place-davis": Stop("College Ave and Elm St, Somerville, MA", 42.39674, -71.121815, 0, "place-davis", "Davis"),
  "place-denrd": Stop("Beacon St and Dean Rd, Brookline, MA", 42.337807, -71.141853, 0, "place-denrd", "Dean Road"),
  "place-FB-0118": Stop("125 Allied Dr, Dedham, MA 02026", 42.227079, -71.174254, 0, "place-FB-0118", "Dedham Corporate Center"),
  "place-dwnxg": Stop("Washington St and Summer St, Boston, MA", 42.355518, -71.060225, 0, "place-dwnxg", "Downtown Crossing"),
  "place-esomr": Stop("134 Washington St, Somerville, MA 02143", 42.379467, -71.086625, 0, "place-esomr", "East Somerville"),
  "place-GRB-0146": Stop("1590 Commercial St, East Weymouth, MA 02189", 42.2191, -70.9214, 0, "place-GRB-0146", "East Weymouth"),
  "place-estav": Stop("None", 42.388374, -71.023859, 0, "place-estav", "Eastern Avenue"),
  "place-eliot": Stop("248 Lincoln St, Newton, MA 02461", 42.319045, -71.216684, 0, "place-eliot", "Eliot"),
  "place-FB-0109": Stop("186 Grant Ave, Dedham, MA 02026", 42.233249, -71.158647, 0, "place-FB-0109", "Endicott"),
  "place-engav": Stop("Beacon St and Englewood Ave, Brookline, MA", 42.336971, -71.14566, 0, "place-engav", "Englewood Avenue"),
  "place-fbkst": Stop("Beacon St and Fairbanks Ave, Brookline, MA", 42.339725, -71.131073, 0, "place-fbkst", "Fairbanks Street"),
  "place-DB-2205": Stop("Fairmount Ave and Truman Hwy, Hyde Park, MA 02136", 42.253638, -71.11927, 0, "place-DB-2205", "Fairmount"),
  "place-fenwy": Stop("411 Park Dr, Boston, MA 02215", 42.345403, -71.104213, 0, "place-fenwy", "Fenway"),
  "place-fenwd": Stop("Huntington Ave and Fenwood Rd, Boston, MA", 42.333706, -71.105728, 0, "place-fenwd", "Fenwood Road"),
  "place-fldcr": Stop("50 Freeman St, Dorchester, MA 02122", 42.300093, -71.061667, 0, "place-fldcr", "Fields Corner"),
  "place-FR-0494": Stop("150 Main St, Fitchburg, MA 01420", 42.58072, -71.792611, 0, "place-FR-0494", "Fitchburg"),
  "place-forhl": Stop("Washington St and Hyde Park Ave, Jamaica Plain, MA 02130", 42.300713, -71.113943, 0, "place-forhl", "Forest Hills"),
  "place-FB-0303": Stop("1000 W Central St, Franklin, MA 02038", 42.089941, -71.43902, 0, "place-FB-0303", "Forge Park/495"),
  "place-DB-2249": Stop("171 Geneva Ave, Boston, MA 02121", 42.305037, -71.076833, 0, "place-DB-2249", "Four Corners/Geneva"),
  "place-FS-0049": Stop("Gillette Stadium near Lots 3 and 4, Foxborough, MA 02035", 42.0951, -71.26151, 0, "place-FS-0049", "Foxboro"),
  "place-WML-0214": Stop("417 Waverly St, Framingham, MA 01702", 42.276108, -71.420055, 0, "place-WML-0214", "Framingham"),
  "place-FB-0275": Stop("75 Depot St, Franklin, MA 02038", 42.083238, -71.396102, 0, "place-FB-0275", "Franklin"),
  "place-gilmn": Stop("161 School St, Somerville, MA 02143", 42.387928, -71.096766, 0, "place-gilmn", "Gilman Square"),
  "place-GB-0316": Stop("75 Railroad Ave, Gloucester, MA 01930", 42.616799, -70.668345, 0, "place-GB-0316", "Gloucester"),
  "place-gover": Stop("Cambridge St and Court St, Boston, MA", 42.359705, -71.059215, 0, "place-gover", "Government Center"),
  "place-WML-0364": Stop("1 Pine St, North Grafton, MA 01536-1856", 42.2466, -71.685325, 0, "place-WML-0364", "Grafton"),
  "place-grnst": Stop("150 Green St, Jamaica Plain, MA", 42.310525, -71.107414, 0, "place-grnst", "Green Street"),
  "place-GRB-0276": Stop("247 Old Driftway, Scituate, MA 02066", 42.178776, -70.746641, 0, "place-GRB-0276", "Greenbush"),
  "place-WR-0085": Stop("907 Main St, Wakefield, MA 01880", 42.483005, -71.067247, 0, "place-WR-0085", "Greenwood"),
  "place-grigg": Stop("Commonwealth Ave and Griggs St, Boston, MA", 42.348545, -71.134949, 0, "place-grigg", "Griggs Street"),
  "place-PB-0281": Stop("6 Garden Rd, Halifax, MA 02338", 42.014739, -70.824263, 0, "place-PB-0281", "Halifax"),
  "place-ER-0227": Stop("Bay Rd and Walnut Rd, Hamilton, MA 01982", 42.609212, -70.874801, 0, "place-ER-0227", "Hamilton/Wenham"),
  "place-PB-0245": Stop("1070 Main St, Hanson, MA 02341", 42.043967, -70.882438, 0, "place-PB-0245", "Hanson"),
  "place-harsq": Stop("1400 Massachusetts Ave, Cambridge, MA", 42.373362, -71.118956, 0, "place-harsq", "Harvard"),
  "place-harvd": Stop("Commonwealth Ave and Harvard Ave, Boston, MA", 42.350243, -71.131355, 0, "place-harvd", "Harvard Avenue"),
  "place-FR-0137": Stop("105 Viles St, Weston, MA 02493", 42.385755, -71.289203, 0, "place-FR-0137", "Hastings"),
  "place-WR-0329": Stop("1 Washington Ave, Haverhill, MA 01832", 42.773474, -71.086237, 0, "place-WR-0329", "Haverhill"),
  "place-hwsst": Stop("Beacon St and Hawes St, Brookline, MA", 42.344906, -71.111145, 0, "place-hwsst", "Hawes Street"),
  "place-haecl": Stop("136 Blackstone St, Boston, MA 02109", 42.363021, -71.05829, 0, "place-haecl", "Haymarket"),
  "place-hsmnl": Stop("Heath St and South Huntington Ave, Boston, MA", 42.328316, -71.110252, 0, "place-hsmnl", "Heath Street"),
  "place-NB-0109": Stop("Great Plain Ave and Broad Meadow Rd, Needham, MA 02492", 42.275648, -71.215528, 0, "place-NB-0109", "Hersey"),
  "place-NB-0076": Stop("Corey St and Hastings St, West Roxbury, MA 02132", 42.284969, -71.153937, 0, "place-NB-0076", "Highland"),
  "place-MM-0150": Stop("Union St and Center St, Randolph, MA 02368", 42.156343, -71.027371, 0, "place-MM-0150", "Holbrook/Randolph"),
  "place-CM-0790": Stop("215 Iyannough Road, Hyannis, MA 02601", 41.660225, -70.276583, 0, "place-CM-0790", "Hyannis"),
  "place-NEC-2203": Stop("1 Pingree St, Hyde Park, MA 02136", 42.25503, -71.125526, 0, "place-NEC-2203", "Hyde Park"),
  "place-hymnl": Stop("100 Massachusetts Ave, Boston, MA", 42.347888, -71.087903, 0, "place-hymnl", "Hynes Convention Center"),
  "place-ER-0276": Stop("4 Peatfield St, Ipswich, MA 01938", 42.676921, -70.840589, 0, "place-ER-0276", "Ipswich"),
  "place-FB-0125": Stop("48 Carroll Ave, Westwood, MA 02090", 42.22105, -71.183961, 0, "place-FB-0125", "Islington"),
  "place-jfk": Stop("599 Old Colony Ave, Boston, MA 02127-3805", 42.320685, -71.052391, 0, "place-jfk", "JFK/UMass"),
  "place-jaksn": Stop("1500 Columbus Ave, Jamaica Plain, MA", 42.323132, -71.099592, 0, "place-jaksn", "Jackson Square"),
  "place-FR-0132": Stop("198 Church St, Weston, MA", 42.37897, -71.282411, 0, "place-FR-0132", "Kendal Green"),
  "place-knncl": Stop("300 Main St, Cambridge, MA 02142", 42.362491, -71.086176, 0, "place-knncl", "Kendall/MIT"),
  "place-kencl": Stop("Commonwealth Ave and Kenmore St, Boston, MA 02215", 42.348949, -71.095169, 0, "place-kencl", "Kenmore"),
  "place-kntst": Stop("Beacon St and Powell St, Brookline, MA", 42.344074, -71.114197, 0, "place-kntst", "Kent Street"),
  "place-KB-0351": Stop("134 Marion Dr, Kingston, MA 02364", 41.97762, -70.721709, 0, "place-KB-0351", "Kingston"),
  "place-WML-0025": Stop("25 David Ortiz Dr, Boston, MA 02215", 42.347581, -71.099974, 0, "place-WML-0025", "Lansdowne"),
  "place-WR-0264": Stop("S Union St and Merrimack St, Lawrence, MA 01843", 42.701806, -71.15198, 0, "place-WR-0264", "Lawrence"),
  "place-lech": Stop("3 North First St, Cambridge, MA 02141", 42.371572, -71.076584, 0, "place-lech", "Lechmere"),
  "place-FR-0167": Stop("160 Lincoln Rd, Lincoln, MA 01773", 42.413641, -71.325512, 0, "place-FR-0167", "Lincoln"),
  "place-FR-0301": Stop("Grimes Ln and Foster St, Littleton, MA 01460", 42.519236, -71.502643, 0, "place-FR-0301", "Littleton/Route 495"),
  "place-longw": Stop("30 Chapel St, Brookline, MA 02446", 42.341702, -71.109956, 0, "place-longw", "Longwood"),
  "place-lngmd": Stop("Huntington Ave and Longwood Ave, Boston, MA 02115", 42.33596, -71.100052, 0, "place-lngmd", "Longwood Medical Area"),
  "place-NHRML-0254": Stop("101 Thorndike St, Lowell, MA 01852", 42.63535, -71.314543, 0, "place-NHRML-0254", "Lowell"),
  "place-ER-0115": Stop("325 Broad St, Lynn, MA 01901", 42.462953, -70.945421, 0, "place-ER-0115", "Lynn"),
  "place-ER-0117": Stop("11 Ellis St, Lynn, MA 01902", 42.46529, -70.940434, 0, "place-ER-0117", "Lynn Interim"),
  "place-mgngl": Stop("270 Lowell St, Somerville, MA 02145", 42.393682, -71.106388, 0, "place-mgngl", "Magoun Square"),
  "place-mlmnl": Stop("Commercial St and Pleasant St, Malden, MA 02148", 42.426632, -71.07411, 0, "place-mlmnl", "Malden Center"),
  "place-GB-0254": Stop("40 Beach St, Manchester, MA 01944", 42.573687, -70.77009, 0, "place-GB-0254", "Manchester"),
  "place-NEC-2040": Stop("1 Crocker St, Mansfield, MA 02048", 42.032787, -71.219917, 0, "place-NEC-2040", "Mansfield"),
  "place-masta": Stop("393 Massachusetts Ave, Boston, MA 02118", 42.341512, -71.083423, 0, "place-masta", "Massachusetts Avenue"),
  "place-matt": Stop("500 River St, Boston, MA 02126", 42.26762, -71.092486, 0, "place-matt", "Mattapan"),
  "place-mvbcl": Stop("Sumner St and Maverick Sq, East Boston, MA", 42.369119, -71.03953, 0, "place-mvbcl", "Maverick"),
  "place-mdftf": Stop("460 Boston Ave, Medford, MA 02155", 42.407975, -71.117044, 0, "place-mdftf", "Medford/Tufts"),
  "place-WR-0075": Stop("497 Franklin St, Melrose, MA 02176", 42.469464, -71.068297, 0, "place-WR-0075", "Melrose Highlands"),
  "place-WR-0067": Stop("Cedar Park and West Emerson St, Melrose, MA 02176", 42.458768, -71.069789, 0, "place-WR-0067", "Melrose/Cedar Park"),
  "place-MM-0356": Stop("125 Commercial Dr, Lakeville, MA 02347", 41.87821, -70.918444, 0, "place-MM-0356", "Middleborough/Lakeville"),
  "place-miltt": Stop("1 Adams St, Milton, MA 02186", 42.270349, -71.067266, 0, "place-miltt", "Milton"),
  "place-NHRML-0116": Stop("250 Mishawum Rd, Woburn, MA 01801", 42.504402, -71.137618, 0, "place-NHRML-0116", "Mishawum"),
  "place-mispk": Stop("Huntington Ave and Mission Park Dr, Boston, MA 02115", 42.333195, -71.109756, 0, "place-mispk", "Mission Park"),
  "place-MM-0186": Stop("150 Spark St, Brockton, MA 02302", 42.106555, -71.022001, 0, "place-MM-0186", "Montello"),
  "place-GB-0198": Stop("180 Essex St, Beverly, MA 01915", 42.562171, -70.869254, 0, "place-GB-0198", "Montserrat"),
  "place-DB-2230": Stop("865 Morton St, Mattapan, MA 02126", 42.280994, -71.085475, 0, "place-DB-2230", "Morton Street"),
  "place-mfa": Stop("Huntington Ave and Ruggles St, Boston, MA", 42.337711, -71.095512, 0, "place-mfa", "Museum of Fine Arts"),
  "place-GRB-0183": Stop("190 Summer St, Hingham, MA 02043", 42.244959, -70.869205, 0, "place-GRB-0183", "Nantasket Junction"),
  "place-WML-0177": Stop("1 Walnut St, Natick, MA 01760", 42.285719, -71.347133, 0, "place-WML-0177", "Natick Center"),
  "place-NB-0127": Stop("Great Plain Ave and Eaton Sq, Needham, MA 02492", 42.280775, -71.237686, 0, "place-NB-0127", "Needham Center"),
  "place-NB-0137": Stop("95 Avery Sq, Needham, MA 02494", 42.293444, -71.236027, 0, "place-NB-0137", "Needham Heights"),
  "place-NB-0120": Stop("51 Junction St, Needham, MA 02492", 42.273187, -71.235559, 0, "place-NB-0120", "Needham Junction"),
  "place-ER-0362": Stop("25 Boston Way, Newburyport, MA 01950", 42.797837, -70.87797, 0, "place-ER-0362", "Newburyport"),
  "place-DB-2265": Stop("1070 Massachusetts Ave, Boston, MA 02118", 42.327415, -71.065674, 0, "place-DB-2265", "Newmarket"),
  "place-newto": Stop("72 Union St, Newton, MA 02459", 42.329443, -71.192414, 0, "place-newto", "Newton Centre"),
  "place-newtn": Stop("60 Station Ave, Newton, MA 02461", 42.322381, -71.205509, 0, "place-newtn", "Newton Highlands"),
  "place-WML-0081": Stop("770 Washington St, Newton, MA 02460", 42.351702, -71.205408, 0, "place-WML-0081", "Newtonville"),
  "place-FB-0230": Stop("9 Rockwood Rd, Norfolk, MA 02056", 42.120694, -71.325217, 0, "place-FB-0230", "Norfolk"),
  "place-ER-0208": Stop("Enon St and Dodge St, Beverly, MA 01915", 42.583779, -70.883851, 0, "place-ER-0208", "North Beverly"),
  "place-NHRML-0218": Stop("Ruggles St and Station St, North Billerica, MA 01862", 42.593248, -71.280995, 0, "place-NHRML-0218", "North Billerica"),
  "place-FR-0451": Stop("44 Nashua St, Leominster, MA 01453", 42.539017, -71.739186, 0, "place-FR-0451", "North Leominster"),
  "place-nqncy": Stop("Hancock St and Hunt St, Quincy, MA 02171", 42.275275, -71.029583, 0, "place-nqncy", "North Quincy"),
  "place-GRB-0233": Stop("777 Country Way, Scituate, MA 02066", 42.219528, -70.788602, 0, "place-GRB-0233", "North Scituate"),
  "place-north": Stop("135 Causeway St, Boston, MA 02114", 42.365577, -71.06129, 0, "place-north", "North Station"),
  "place-WR-0163": Stop("370 Middlesex Ave, Wilmington, MA 01887", 42.569661, -71.159696, 0, "place-WR-0163", "North Wilmington"),
  "place-nuniv": Stop("Huntington Ave and Opera Pl, Boston, MA 02115", 42.340401, -71.088806, 0, "place-nuniv", "Northeastern University"),
  "place-FB-0148": Stop("164 Broadway, Norwood, MA 02062", 42.188775, -71.199665, 0, "place-FB-0148", "Norwood Central"),
  "place-FB-0143": Stop("14 Hill St, Norwood, MA 02062", 42.196857, -71.196688, 0, "place-FB-0143", "Norwood Depot"),
  "place-nubn": Stop("Washington St and Dudley St, Roxbury, MA", 42.329544, -71.083982, 0, "place-nubn", "Nubian"),
  "place-ogmnl": Stop("Washington St and Winter St, Malden, MA 02148", 42.43668, -71.071097, 0, "place-ogmnl", "Oak Grove"),
  "place-orhte": Stop("1000 Bennington St, East Boston, MA 02128", 42.386867, -71.004736, 0, "place-orhte", "Orient Heights"),
  "place-brico": Stop("Commonwealth Ave and Brighton Ave, Boston, MA 02215", 42.351967, -71.125031, 0, "place-brico", "Packard's Corner"),
  "place-pktrm": Stop("Tremont St and Winter St, Boston, MA 02108", 42.356395, -71.062424, 0, "place-pktrm", "Park Street"),
  "place-NEC-1891": Stop("300 Pine St, Pawtucket, RI 02860", 41.878762, -71.392, 0, "place-NEC-1891", "Pawtucket/Central Falls"),
  "place-FB-0177": Stop("185 Plimpton St, Walpole, MA 02081", 42.159123, -71.236125, 0, "place-FB-0177", "Plimptonville"),
  "place-PB-0356": Stop("385 Court St, Plymouth, MA 02360", 41.981278, -70.690421, 0, "place-PB-0356", "Plymouth"),
  "place-portr": Stop("1899 Massachusetts Ave, Cambridge, MA 02140", 42.3884, -71.119149, 0, "place-portr", "Porter"),
  "place-GB-0222": Stop("600 Hale St, Beverly, MA 01915", 42.559446, -70.825541, 0, "place-GB-0222", "Prides Crossing"),
  "place-NEC-1851": Stop("100 Gaspee St, Providence, RI 02903", 41.829293, -71.413301, 0, "place-NEC-1851", "Providence"),
  "place-prmnl": Stop("Huntington Ave and Belvidere St, Boston, MA 02199", 42.34557, -71.081696, 0, "place-prmnl", "Prudential"),
  "place-qamnl": Stop("Burgin Pkwy and Centre St, Quincy, MA 02169", 42.233391, -71.007153, 0, "place-qamnl", "Quincy Adams"),
  "place-qnctr": Stop("175 Thomas E Burgin Pkwy, Quincy, MA 02169", 42.251809, -71.005409, 0, "place-qnctr", "Quincy Center"),
  "place-WR-0120": Stop("35 Lincoln St, Reading, MA 01867", 42.52221, -71.108294, 0, "place-WR-0120", "Reading"),
  "place-DB-0095": Stop("1800 Hyde Park Ave, Hyde Park, MA 02136", 42.238405, -71.133246, 0, "place-DB-0095", "Readville"),
  "place-rsmnl": Stop("401 Chestnut Hill Ave, Brookline, MA 02445", 42.335088, -71.148758, 0, "place-rsmnl", "Reservoir"),
  "place-rbmnl": Stop("220 Shirley Ave, Revere, MA", 42.407843, -70.992533, 0, "place-rbmnl", "Revere Beach"),
  "place-ER-0099": Stop("1000 Western Ave, Lynn, MA 01910 (General Electric employees only)", 42.449927, -70.969848, 0, "place-ER-0099", "River Works"),
  "place-river": Stop("367 Grove St, Newton, MA 02466", 42.337352, -71.252685, 0, "place-river", "Riverside"),
  "place-rvrwy": Stop("South Huntington Ave and Huntington Ave, Boston, MA", 42.331684, -71.111931, 0, "place-rvrwy", "Riverway"),
  "place-GB-0353": Stop("17 Railroad Ave, Rockport, MA 01966", 42.655491, -70.627055, 0, "place-GB-0353", "Rockport"),
  "place-NB-0064": Stop("1 Belgrade Ave, Roslindale, MA 02131", 42.287442, -71.130283, 0, "place-NB-0064", "Roslindale Village"),
  "place-NEC-2173": Stop("50 University Ave, Westwood, MA 02090", 42.210308, -71.147134, 0, "place-NEC-2173", "Route 128"),
  "place-ER-0312": Stop("70 Railroad Ave, Rowley, MA 01969", 42.726845, -70.859034, 0, "place-ER-0312", "Rowley"),
  "place-rcmnl": Stop("1400 Tremont St, Roxbury, MA", 42.331397, -71.095451, 0, "place-rcmnl", "Roxbury Crossing"),
  "place-rugg": Stop("1150 Tremont St, Roxbury, MA 02120", 42.336377, -71.088961, 0, "place-rugg", "Ruggles"),
  "place-smary": Stop("Beacon St and Saint Mary's St, Boston, MA", 42.345974, -71.107353, 0, "place-smary", "Saint Mary's Street"),
  "place-stpul": Stop("Beacon St and Saint Paul St, Brookline, MA 02446", 42.343327, -71.116997, 0, "place-stpul", "Saint Paul Street"),
  "place-ER-0168": Stop("252 Bridge St, Salem, MA 01970", 42.524792, -70.895876, 0, "place-ER-0168", "Salem"),
  "place-shmnl": Stop("125 Savin Hill Ave, Dorchester, MA 02124", 42.31129, -71.053331, 0, "place-shmnl", "Savin Hill"),
  "place-spmnl": Stop("Leverett Circle and Nashua St, Boston, MA 02114", 42.366664, -71.067666, 0, "place-spmnl", "Science Park/West End"),
  "place-NEC-2108": Stop("1 Upland Rd, Sharon, MA 02067", 42.124553, -71.184468, 0, "place-NEC-2108", "Sharon"),
  "place-smmnl": Stop("Dayton St and Clementine Park, Dorchester, MA 02124", 42.293126, -71.065738, 0, "place-smmnl", "Shawmut"),
  "place-FR-0394": Stop("Ayer Rd and Phoenix St, Shirley, MA 01464", 42.545089, -71.648004, 0, "place-FR-0394", "Shirley"),
  "place-FR-0147": Stop("Silver Hill Rd and Merriam St, Weston, MA 02493", 42.395625, -71.302357, 0, "place-FR-0147", "Silver Hill"),
  "place-conrd": Stop("None", 42.347154, -71.038385, 0, "place-conrd", "Silver Line Way"),
  "place-FR-0253": Stop("4 Central St, Acton, MA 01720", 42.460375, -71.457744, 0, "place-FR-0253", "South Acton"),
  "place-NEC-1919": Stop("1315 Newport Ave, Attleboro, MA 02703", 41.897943, -71.354621, 0, "place-NEC-1919", "South Attleboro"),
  "place-sstat": Stop("700 Atlantic Ave, Boston, MA 02110", 42.352271, -71.055242, 0, "place-sstat", "South Station"),
  "place-sougr": Stop("None", 42.3396, -71.157661, 0, "place-sougr", "South Street"),
  "place-PB-0158": Stop("89 Trotter Rd, Weymouth, MA 02190", 42.155025, -70.953302, 0, "place-PB-0158", "South Weymouth"),
  "place-WML-0274": Stop("87 Southville Rd, Southborough, MA 01772", 42.267024, -71.524371, 0, "place-WML-0274", "Southborough"),
  "place-state": Stop("200 Washington St, Boston, MA", 42.358978, -71.057598, 0, "place-state", "State"),
  "place-sbmnl": Stop("100 Boylston St, Jamaica Plain, MA", 42.317062, -71.104248, 0, "place-sbmnl", "Stony Brook"),
  "place-SB-0189": Stop("45 Wyman St, Stoughton, MA 02072", 42.124084, -71.103627, 0, "place-SB-0189", "Stoughton"),
  "place-sdmnl": Stop("1230 Bennington St, East Boston, MA 02128", 42.390501, -70.997123, 0, "place-sdmnl", "Suffolk Downs"),
  "place-sull": Stop("Maffa Way and Cambridge St, Charlestown, MA 02129", 42.383975, -71.076994, 0, "place-sull", "Sullivan Square"),
  "place-sumav": Stop("Beacon St and Summit Ave, Brookline, MA", 42.34111, -71.12561, 0, "place-sumav", "Summit Avenue"),
  "place-sthld": Stop("Commonwealth Ave and Sutherland Rd, Boston, MA", 42.341614, -71.146202, 0, "place-sthld", "Sutherland Road"),
  "place-ER-0128": Stop("Burrill St and Railroad Ave, Swampscott, MA 01907", 42.473743, -70.922537, 0, "place-ER-0128", "Swampscott"),
  "place-symcl": Stop("Massachusetts Ave and Huntington Ave, Boston, MA", 42.342687, -71.085056, 0, "place-symcl", "Symphony"),
  "place-NEC-1768": Stop("700 Jefferson Blvd, Warwick, RI 02886", 41.726599, -71.442453, 0, "place-NEC-1768", "TF Green Airport"),
  "place-DB-2240": Stop("210 Talbot Ave, Boston, MA 02124", 42.292246, -71.07814, 0, "place-DB-2240", "Talbot Avenue"),
  "place-tapst": Stop("Beacon St and Tappan St, Brookline, MA", 42.338459, -71.138702, 0, "place-tapst", "Tappan Street"),
  "place-tumnl": Stop("750 Washington St, Boston, MA", 42.349662, -71.063917, 0, "place-tumnl", "Tufts Medical Center"),
  "place-unsqu": Stop("50 Prospect St, Somerville, MA 02143", 42.377359, -71.094761, 0, "place-unsqu", "Union Square"),
  "place-DB-2258": Stop("691 Dudley St, Dorchester, MA 02125", 42.319125, -71.068627, 0, "place-DB-2258", "Uphams Corner"),
  "place-valrd": Stop("291 Valley Rd, Milton, MA 02186", 42.268347, -71.081343, 0, "place-valrd", "Valley Road"),
  "place-waban": Stop("Beacon St and Waban Sq, Newton, MA 02468", 42.325845, -71.230609, 0, "place-waban", "Waban"),
  "place-FR-3338": Stop("55 Authority Dr, Fitchburg, MA 01420", 42.553477, -71.848488, 0, "place-FR-3338", "Wachusett"),
  "place-WR-0099": Stop("225 North Ave, Wakefield, MA 01880", 42.502126, -71.075566, 0, "place-WR-0099", "Wakefield"),
  "place-FB-0191": Stop("275 West St, Walpole, MA 02081", 42.145477, -71.25779, 0, "place-FB-0191", "Walpole"),
  "place-FR-0098": Stop("75 Carter St, Waltham, MA 02453", 42.374296, -71.235615, 0, "place-FR-0098", "Waltham"),
  "place-CM-0493": Stop("176 Merchants Way, Wareham, MA 02571", 41.758333, -70.714722, 0, "place-CM-0493", "Wareham Village"),
  "place-wrnst": Stop("Commonwealth Ave and Warren St, Boston, MA", 42.348343, -71.140457, 0, "place-wrnst", "Warren Street"),
  "place-bcnwa": Stop("Beacon St and Washington St, Brookline, MA", 42.339394, -71.13533, 0, "place-bcnwa", "Washington Square"),
  "place-wascm": Stop("Commonwealth Ave and Washington St, Boston, MA", 42.343864, -71.142853, 0, "place-wascm", "Washington Street"),
  "place-FR-0074": Stop("525 Trapelo Rd, Belmont, MA 02478", 42.3876, -71.190744, 0, "place-FR-0074", "Waverley"),
  "place-NHRML-0073": Stop("25 Mystic Valley Pkwy, Winchester, MA 01890", 42.444948, -71.140169, 0, "place-NHRML-0073", "Wedgemere"),
  "place-WML-0125": Stop("90 Croton St, Wellesley, MA 02481", 42.323608, -71.272288, 0, "place-WML-0125", "Wellesley Farms"),
  "place-WML-0135": Stop("341 Washington St, Wellesley, MA 02481", 42.31037, -71.277044, 0, "place-WML-0135", "Wellesley Hills"),
  "place-WML-0147": Stop("1 Grove St, Wellesley, MA 02482", 42.297526, -71.294173, 0, "place-WML-0147", "Wellesley Square"),
  "place-welln": Stop("Revere Beach Pkwy and Rivers Edge Dr, Medford, MA 02155", 42.40237, -71.077082, 0, "place-welln", "Wellington"),
  "place-FR-0219": Stop("Commonwealth Ave and Main St, West Concord, MA 01742", 42.457043, -71.392892, 0, "place-FR-0219", "West Concord"),
  "place-GB-0296": Stop("290 Essex Ave, Gloucester, MA 01930", 42.611933, -70.705417, 0, "place-GB-0296", "West Gloucester"),
  "place-GRB-0162": Stop("20 Fort Hill Rd, Hingham, MA 02043", 42.235838, -70.902708, 0, "place-GRB-0162", "West Hingham"),
  "place-NHRML-0055": Stop("481 High St, Medford, MA 02155", 42.421776, -71.133342, 0, "place-NHRML-0055", "West Medford"),
  "place-WML-0199": Stop("249 West Central St, Natick, MA 01760", 42.283064, -71.391797, 0, "place-WML-0199", "West Natick"),
  "place-WML-0091": Stop("1395 Washington St, Newton, MA 02465", 42.347878, -71.230528, 0, "place-WML-0091", "West Newton"),
  "place-NB-0080": Stop("450 Lagrange St, West Roxbury, MA 02132", 42.281358, -71.160065, 0, "place-NB-0080", "West Roxbury"),
  "place-WML-0340": Stop("Smith Pkwy and Fisher St, Westborough, MA 01581", 42.269644, -71.647076, 0, "place-WML-0340", "Westborough"),
  "place-GRB-0118": Stop("121 Commercial St, Weymouth, MA 02184", 42.221503, -70.968152, 0, "place-GRB-0118", "Weymouth Landing/East Braintree"),
  "place-PB-0212": Stop("383 South Ave, Whitman, MA 02382", 42.082749, -70.923411, 0, "place-PB-0212", "Whitman"),
  "place-NEC-1659": Stop("1011 Ten Rod Rd, North Kingstown, RI", 41.581289, -71.491147, 0, "place-NEC-1659", "Wickford Junction"),
  "place-NHRML-0152": Stop("405 Main St, Wilmington, MA 01887", 42.546624, -71.174334, 0, "place-NHRML-0152", "Wilmington"),
  "place-NHRML-0078": Stop("29 Waterfield Rd, Winchester, MA 01890", 42.451088, -71.13783, 0, "place-NHRML-0078", "Winchester Center"),
  "place-FB-0166": Stop("Buckminster Dr and Engamore Ln, Norwood, MA 02062", 42.172127, -71.219366, 0, "place-FB-0166", "Windsor Gardens"),
  "place-wlsta": Stop("90 Woodbine St, Quincy, MA 02171", 42.266514, -71.020337, 0, "place-wlsta", "Wollaston"),
  "place-wondl": Stop("1300 North Shore Rd, Revere, MA 02151", 42.41342, -70.991648, 0, "place-wondl", "Wonderland"),
  "place-wimnl": Stop("450 Bennington St, East Boston, MA", 42.37964, -71.022865, 0, "place-wimnl", "Wood Island"),
  "place-woodl": Stop("1940 Washington St, Newton, MA 02466", 42.332902, -71.243362, 0, "place-woodl", "Woodland"),
  "place-WML-0442": Stop("2 Washington Sq, Worcester, MA 01608", 42.261835, -71.791806, 0, "place-WML-0442", "Worcester"),
  "place-wtcst": Stop("Congress St and World Trade Center Ave, Boston, MA", 42.34863, -71.04246, 0, "place-wtcst", "World Trade Center"),
  "place-WR-0062": Stop("40 West Wyoming Ave, Melrose, MA 02176", 42.451731, -71.069379, 0, "place-WR-0062", "Wyoming Hill"),

};