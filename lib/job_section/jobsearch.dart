
import 'package:broadway/common/colors.dart';
import 'package:broadway/common/images.dart';
// import 'package:broadway/job_app/Filter_page.dart';
// import 'package:broadway/job_app/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'filter_page.dart';
import 'notification.dart';
import 'one_job desc.dart';
// import 'one job_desc.dart';
// import 'one_job desc.dart';
class PageContainer {
  final String name;
  final Widget page;
  PageContainer({required this.name, required this.page});
}
class JobSearch extends StatefulWidget {
  @override
  State<JobSearch> createState() => _JobSearchState();
}

class _JobSearchState extends State<JobSearch> {
  final String userName = "John";
  int selectedIndex = -1;
  List<Map<String, dynamic>> savedJobs = [];

  final List<Map<String, dynamic>> jobs = [
    {
      "name": "Software Developer",
      "jobname": "Full-Time",
      "help": "Develop applications.",
      "image": theImages.uidesigner,
    },
    // {
    //   "name": "Data Scientist",
    //   "jobname": "Part-Time",
    //   "help": "Analyze data and build models.",
    //   "image": "",
    // },
  ];

  List<PageContainer> containers = [];

  @override
  void initState() {
    super.initState();
    containers = [
      PageContainer(name: 'Search', page: const SearchPage()),
      PageContainer(name: 'Saved', page: SavedJobs(savedJobs: savedJobs)),
      PageContainer(name: 'Applied', page: const AppliedPage()),
      PageContainer(name: 'Recommended', page: const RecommendedPage()),
    ];
  }
  void saveJob(Map<String, dynamic> job) {
    setState(() {
      savedJobs.add(job);
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedJobs(savedJobs: savedJobs),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        height: h * 0.48,
                        // color: Colors.blue,
                        child:Image.asset(theImages.sideview),
                      ),
                    ),
                    SizedBox(width: w * 0.01),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: h * 0.3,
                        child:Image.asset(theImages.sideview2),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: h * 0.09,
                  left: w * 0.05,
                  child: Text(
                    'Hello, $userName!',
                    style: TextStyle(
                      fontSize: w * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  bottom: h * 0.18,
                  left: w * 0.05,
                  right: w * 0.05,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(w * 0.04),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: h * 0.02,
                        horizontal: w * 0.04,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: h * 0.1,
                  left: w * 0.05,
                  right: w * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(containers.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });

                          if (index == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SavedJobs(savedJobs: savedJobs),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => containers[index].page,
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: w * 0.2,
                          height: h * 0.06,
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.blue
                                : Colors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(w * 0.02),
                          ),
                          child: Center(
                            child: Text(
                              containers[index].name,
                              style: TextStyle(
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.w800,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Popular Jobs",
                      style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    SizedBox(width: w*0.5),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => filterpage(),));
                        },
                        child: Container(child: Image.asset(theImages.filter))),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>notification() ,));
                        },
                        child: Container(child: Image.asset(theImages.bell))),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: h * 0.5,
                  child: ListView.builder(
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      final job = jobs[index];
                      return Padding(
                        padding:  EdgeInsets.all(w*0.03),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OneJobDesc(jobData: {},),));
                          },
                          child: Container(
                            height: h*0.29,
                            width: w*0.3,
                            decoration: BoxDecoration(
                                color: thecolors.gray4,
                                borderRadius: BorderRadiusDirectional.circular(w*0.03)
                            ),
                            child: ListTile(
                              title: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(theImages.uidesigner),
                                        SizedBox(width: w*0.01,),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(job["name"].toString()),
                                            Text('designer')
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text("About Job"),
                                    Divider(
                                      color: Colors.grey,
                                      indent: h*0.03,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 6, // Adjust the size of the dot
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Text(' Help the team to craft the brand story & set ',style: TextStyle(
                                                fontSize: w*0.03
                                            ),),
                                          ],
                                        ),
                                        SizedBox(height: h*0.01,),
                                        Text('up for merchants we onboard',style: TextStyle(
                                            fontSize: w*0.03
                                        ),),
                                        SizedBox(height: h*0.01,),
                                        Row(
                                          children: [
                                            Container(
                                              width: 6, // Adjust the size of the dot
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(height: h*0.01,),
                                            Text('Manage relations with our partners/corporate',style: TextStyle(
                                                fontSize: w*0.03
                                            ),),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),

                              ),
                              // subtitle: Text(job["jobname"].toString()),
                              trailing: IconButton(
                                icon: const Icon(Icons.bookmark_border_outlined),
                                onPressed: () {
                                  saveJob(job);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SavedJobs extends StatelessWidget {
  final List<Map<String, dynamic>> savedJobs;

  const SavedJobs({Key? key, required this.savedJobs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Jobs"),
        centerTitle: true,
      ),
      body: savedJobs.isEmpty
          ? const Center(child: Text("No saved jobs yet."))
          : ListView.builder(
        itemCount: savedJobs.length,
        itemBuilder: (context, index) {
          final job = savedJobs[index];
          return Padding(
            padding:  EdgeInsets.all(w*0.03),
            child: Container(
              height: h*0.19,
              width: w*0.3,
              decoration: BoxDecoration(
                  color: thecolors.gray4,
                  borderRadius: BorderRadiusDirectional.circular(w*0.03)
              ),

              child: ListTile(
                title: Text(job["name"]),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(job["jobname"]),
                    Icon(CupertinoIcons.bookmark_fill)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Page")),
      body: const Center(child: Text("Search Page Content")),
    );
  }
}

class AppliedPage extends StatelessWidget {
  const AppliedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Applied Page")),
      body: const Center(child: Text("Applied Page Content")),
    );
  }
}

class RecommendedPage extends StatelessWidget {
  const RecommendedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recommended Page")),
      body: const Center(child: Text("Recommended Page Content")),
    );
  }
}
