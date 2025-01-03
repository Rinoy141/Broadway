//
// import 'package:flutter/material.dart';
//
// class SavedJobs extends StatefulWidget {
//   final List<Map<String, dynamic>> savedJobs;
//
//   const SavedJobs({Key? key, required this.savedJobs}) : super(key: key);
//
//   @override
//   State<SavedJobs> createState() => _SavedJobsState();
// }
//
// class _SavedJobsState extends State<SavedJobs> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Saved Jobs",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context); // Navigate back
//           },
//         ),
//       ),
//       body: widget.savedJobs.isEmpty
//           ? const Center(
//         child: Text(
//           "No saved jobs yet!",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//         ),
//       )
//           : ListView.builder(
//         itemCount: widget.savedJobs.length,
//         itemBuilder: (context, index) {
//           final job = widget.savedJobs[index];
//           final jobName = job["name"] ?? "Unknown Job";
//           final jobTitle = job["jobname"] ?? "No Title Available";
//           final jobHelp = job["help"] ?? "No Description";
//
//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             elevation: 3,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: ListTile(
//               leading: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: job["image"] != null && job["image"].isNotEmpty
//                     ? Image.asset(
//                   job["image"],
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover,
//                 )
//                     : const Icon(Icons.image, size: 50, color: Colors.grey),
//               ),
//               title: Text(
//                 jobName,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 4),
//                   Text(jobTitle),
//                   const SizedBox(height: 4),
//                   Text(
//                     jobHelp,
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//               trailing: IconButton(
//                 icon: const Icon(Icons.delete, color: Colors.red),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text("Remove Job"),
//                         content: const Text("Are you sure you want to remove this job?"),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text("Cancel"),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 widget.savedJobs.removeAt(index);
//                               });
//                               Navigator.pop(context);
//                             },
//                             child: const Text("Remove"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
// import 'job_search.dart';
// import 'saved_jobs.dart'; // Import the SavedJobs page

class JobListPage extends StatefulWidget {
  @override
  _JobListPageState createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  List<Map<String, dynamic>> savedJobs = []; // List to hold saved jobs

  void saveJob(Map<String, dynamic> job) {
    setState(() {
      savedJobs.add(job); // Add the job to saved jobs
    });

    // Navigate to SavedJobs page
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SavedJobs(savedJobs: savedJobs),
    //   ),
    // );
  }
  @override
  Widget build(BuildContext context) {
    // Example job data
    List<Map<String, dynamic>> jobs = [
      {
        "name": "Software Developer",
        "jobname": "Full-Time",
        "help": "Develop applications.",
        "image": "", // Use a valid asset path for images
      },
      // {
      //   "name": "Data Scientist",
      //   "jobname": "Part-Time",
      //   "help": "Analyze data and build models.",
      //   "image": "",
      // },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Listings"),
      ),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return ListTile(
            title: Text(job["name"]),
            subtitle: Text(job["jobname"]),
            trailing: IconButton(
              icon: const Icon(Icons.bookmark_add),
              onPressed: () {
                saveJob(job); // Call saveJob when the job is saved
              },
            ),
          );
        },
      ),
    );
  }
}
