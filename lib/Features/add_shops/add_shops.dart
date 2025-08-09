import 'package:flutter/material.dart';

class AddShopsView extends StatefulWidget {
  const AddShopsView({super.key});

  @override
  State<AddShopsView> createState() =>
      _AddShopsViewState();
}

class _AddShopsViewState
    extends State<AddShopsView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _departmentController = TextEditingController();
  final _reasonController = TextEditingController();
  String? _leaveType = 'Sick Leave'; // default selected
  //String? _leaveType;
  DateTime? _startDate;
  DateTime? _endDate;

  final Color primaryBlue = const Color(0xFF5D6EFF);

  _selectDate(BuildContext context, bool isStart) async {
    final initialDate = isStart
        ? DateTime.now()
        : (_startDate != null
              ? _startDate!.add(const Duration(days: 1))
              : DateTime.now());

    final firstDate = isStart
        ? DateTime.now()
        : (_startDate != null
              ? _startDate!.add(const Duration(days: 1))
              : DateTime.now());

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null &&
              (_endDate!.isBefore(picked) ||
                  _endDate!.isAtSameMomentAs(picked))) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_leaveType != 'Sick Leave') {
        if (_startDate == null || _endDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please select both start and end dates'),
            ),
          );
          return;
        } else if (_endDate!.isBefore(_startDate!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('End date cannot be before start date'),
            ),
          );
          return;
        } else if (_endDate!.isAtSameMomentAs(_startDate!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Start and End date cannot be the same'),
            ),
          );
          return;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Leave Application Submitted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Add Shop".toUpperCase(),
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),

      // appbartitle: 'Leave Request',
      // isDrawerRequired: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Shop Name",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),

              _buildTextField(_nameController, 'Owner Name'),
              const Text(
                "Owner Name",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              _buildTextField(_emailController, 'Owner Name'),
              const Text(
                "Contract Number",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
               SizedBox(height: 5),
               _buildTextField(_emailController, 'Contact Number'),
               SizedBox(height: 5),
                     const Text(
                "Location",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
               SizedBox(height: 5),
              _buildTextField(_emailController, 'Location'),
            
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: _submitForm,
                  child: Container(
                    height: 40,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue,
                    ),
                    child: const Center(
                      child: Text(
                        'Add Shop',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          hintStyle: TextStyle(fontSize: 14),
        ),
        validator: (value) => value!.isEmpty ? 'This field is required' : null,
      ),
    );
  }

  Widget _buildDateField(BuildContext context, bool isStart) {
    final date = isStart ? _startDate : _endDate;
    final label = isStart ? "Start Date" : "End Date";
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          if (!isStart && _startDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select Start Date first')),
            );
            return;
          }
          _selectDate(context, isStart);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            date == null
                ? 'Select date'
                : date.toLocal().toString().split(' ')[0],
          ),
        ),
      ),
    );
  }
}
