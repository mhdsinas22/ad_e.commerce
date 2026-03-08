import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/checkout/domain/enitites/address_entity.dart';
import 'package:ad_e_commerce/core/constants/indian_states.dart';
import 'package:flutter/material.dart';

class AddressSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController mobileController;
  final TextEditingController pincodeController;
  final TextEditingController houseController;
  final TextEditingController localityController;
  final TextEditingController landmarkController;
  final TextEditingController emailController;
  final TextEditingController alternateNumberController;
  final List<AddressEntity> addresses;
  final String selectedSaveAs;
  final ValueChanged<String> onSaveAsChanged;
  final String? selectedState;
  final String? selectedDistrict;
  final ValueChanged<String?> onStateChanged;
  final ValueChanged<String?> onDistrictChanged;
  final int selectedAddressIndex;
  final ValueChanged<int> onAddressSelected;
  final bool isEditingAddress;
  final Function(AddressEntity address, int index) onEditAddress;
  final bool isEdit;

  const AddressSection({
    super.key,
    required this.nameController,
    required this.mobileController,
    required this.pincodeController,
    required this.houseController,
    required this.localityController,
    required this.landmarkController,
    required this.emailController,
    required this.alternateNumberController,
    required this.selectedSaveAs,
    required this.onSaveAsChanged,
    required this.selectedState,
    required this.selectedDistrict,
    required this.onStateChanged,
    required this.onDistrictChanged,
    required this.addresses,
    required this.selectedAddressIndex,
    required this.onAddressSelected,
    required this.isEdit,
    required this.onEditAddress,
    required this.isEditingAddress,
  });

  @override
  State<AddressSection> createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  @override
  Widget build(BuildContext context) {
    final addNewIndex = widget.addresses.length;
    final shouldShowForm =
        widget.selectedAddressIndex == addNewIndex || widget.isEditingAddress;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 160,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Select your Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.addresses.length,
                itemBuilder: (context, index) {
                  final address = widget.addresses[index];
                  return _buildAddressOption(
                    index: index,
                    label: address.saveAs.toUpperCase(),
                    sublabel:
                        '${address.house}, ${address.area}, ${address.pincode}',
                  );
                },
              ),

              SizedBox(height: 16),
              _buildAddressOption(
                index: addNewIndex,
                label: 'Add new',
                isAddNew: true,
              ),

              if (shouldShowForm) ...[
                SizedBox(height: 30),
                _buildTextField(
                  label: 'Full Name*',
                  hint: 'Enter your full name',
                  controller: widget.nameController,
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  label: 'Mobile Number*',
                  hint: '10-digit mobile number',
                  controller: widget.mobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                ),

                const SizedBox(height: 20),

                // State & District Dropdowns
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        label: 'State*',
                        value: widget.selectedState,
                        items: IndianStates.stateDistricts.keys.toList(),
                        onChanged: widget.onStateChanged,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdown(
                        label: 'District*',
                        value: widget.selectedDistrict,
                        items:
                            widget.selectedState != null
                                ? IndianStates.stateDistricts[widget
                                        .selectedState] ??
                                    []
                                : [],
                        onChanged: widget.onDistrictChanged,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  label: 'Enter Pincode*',
                  hint: 'Eg: 676517',
                  controller: widget.pincodeController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  label: 'Flat no./ H no./ Office*',
                  hint: 'House name / Flat number',
                  controller: widget.houseController,
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  label: 'Locality/Area/Street',
                  hint: 'Area / Street name',
                  controller: widget.localityController,
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  label: 'Landmark (optional)',
                  hint: 'Near temple / school',
                  controller: widget.landmarkController,
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  label: 'Email*',
                  hint: 'example@email.com',
                  controller: widget.emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20),

                _buildTextField(
                  label: 'Alternate number (optional)',
                  hint: 'Optional phone number',
                  controller: widget.alternateNumberController,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 30),

                const Text(
                  'Save As',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),

                SizedBox(height: 10),
                Row(
                  children: [
                    _buildSaveAsOption('Home'),
                    SizedBox(width: 20),
                    _buildSaveAsOption('Office'),
                    SizedBox(width: 20),
                    _buildSaveAsOption('Other'),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressOption({
    required int index,
    required String label,
    String? sublabel,
    bool isAddNew = false,
  }) {
    final isSelected = widget.selectedAddressIndex == index;
    return InkWell(
      onTap: () {
        widget.onAddressSelected(index);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.black : Colors.grey,
                width: 2,
              ),
            ),
            child:
                isSelected
                    ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
                    )
                    : null,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                if (sublabel != null)
                  Text(
                    sublabel,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
              ],
            ),
          ),
          (widget.isEdit && index < widget.addresses.length)
              ? GestureDetector(
                onTap: () {
                  widget.onEditAddress(widget.addresses[index], index);
                },
                child: Container(
                  height: 20,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlack,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: AppTexts.medium(
                      "Edit",
                      fontSize: 12,
                      color: AppColors.pureWhite,
                    ),
                  ),
                ),
              )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          TextFormField(
            keyboardType: keyboardType,
            controller: controller,
            maxLength: maxLength,
            decoration: InputDecoration(
              hintText: hint,
              counterText: "",
              hintStyle: TextStyle(
                fontSize: 15,
                color: Colors.grey[500],
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : null,
              isExpanded: true,
              hint: Text("Select"),
              icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
              items:
                  items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    );
                  }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveAsOption(String value) {
    final isSelected = widget.selectedSaveAs == value;
    return InkWell(
      onTap: () {
        setState(() {
          widget.onSaveAsChanged(value);
        });
      },
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.black : Colors.black,
                width: isSelected ? 5 : 2, // Thick border looks like filled
              ), // Or actual radio logic
            ),
            child:
                isSelected
                    ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                    : null,
          ),
          SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
