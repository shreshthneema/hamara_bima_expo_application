import "dart:async";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_typeahead/flutter_typeahead.dart";
import "package:hamara_bima_expo_application/features/screens/qr_scanner_screen.dart";
import "package:hamara_bima_expo_application/utils/extensions/build_context_ext.dart";

import "../../utils/constants.dart";

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final bool readOnly;
  final bool autoFocus;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Widget? suffix;
  final Widget? prefix;
  final int? maxLength;
  final int? maxLines;
  final Color textColor;
  final Color titleTextColor;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? text;
  final bool showRequired;
  final bool disabled;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final void Function(String)? onFieldSubmitted;

  const CommonTextField({super.key, this.hintText, this.keyboardType, this.textInputAction = TextInputAction.done, this.titleTextColor = blackColor, this.maxLength, this.textColor = blackColor, this.onChanged, this.onTap, this.controller, this.readOnly = false, this.autoFocus = false, this.validator, this.text, this.showRequired = false, this.disabled = false, this.obscureText = false, this.textCapitalization = TextCapitalization.none, this.inputFormatters, this.suffix, this.maxLines, this.prefix, this.focusNode, this.onFieldSubmitted, this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    return text != null ? Column(children: [buildFormTitle(text!, showRequired), buildTextFormField()]) : buildTextFormField();
  }

  Widget buildTextFormField() {
    return TextFormField(
      obscureText: obscureText,
      focusNode: focusNode,
      autofocus: autoFocus,
      readOnly: readOnly,
      maxLines: maxLines,
      onTap: onTap,
      controller: controller,
      style: TextStyle(color: textColor, fontWeight: FontWeight.w400, fontSize: 15),
      onFieldSubmitted: onFieldSubmitted ?? (nextFocusNode != null ? (_) => nextFocusNode?.requestFocus() : null),
      textCapitalization: textCapitalization,
      validator: validator,
      keyboardType: keyboardType,
      maxLength: maxLength,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        enabled: !disabled,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: blackColor, fontFamily: fontFamilyName),
        prefixIcon: prefix,
        suffixIcon: suffix,
      ).applyDefaults(inputDecorationThemeMain),
      onChanged: onChanged,
    );
  }

  Widget buildFormTitle(String title, bool required) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(color: titleTextColor, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          if (required)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text("*", style: TextStyle(color: Colors.red, fontSize: 12)),
            ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<TextInputFormatter>("inputFormatters", inputFormatters));
  }
}

class CommonDropDown<T> extends StatelessWidget {
  final String? hintText;
  final T? selectedValue;
  final bool isRead;
  final Widget? icon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;

  final Color textColor;
  final Color titleTextColor;
  final ValueChanged<T?>? onChanged;
  final String Function(T) toShow;
  final GestureTapCallback? onTap;
  final Iterable<T> items;
  final String? text;
  final bool showRequired;

  final Widget Function(T data)? buildItem;

  const CommonDropDown({super.key, this.hintText, this.textColor = blackColor, this.titleTextColor = whiteColor, this.onChanged, this.onTap, this.icon, this.suffixIcon, this.isRead = false, required this.items, required this.toShow, required this.selectedValue, this.text, this.showRequired = false, this.buildItem, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return text != null ? Column(children: [buildFormTitle(text!, showRequired), buildDropdownButtonFormField(context)]) : buildDropdownButtonFormField(context);
  }

  Widget buildDropdownButtonFormField(BuildContext context) {
    return DropdownButtonFormField(
      value: selectedValue,
      // readOnly: isRead,
      padding: EdgeInsets.zero,
      isExpanded: true,
      onTap: onTap,
      dropdownColor: whiteColor,
      // controller: controller,
      style: const TextStyle(color: blackColor, fontWeight: FontWeight.w400, fontFamily: fontFamilyName, fontSize: 15),

      focusNode: focusNode,
      items: items.map((e) {
        return DropdownMenuItem(
          value: e,
          child: buildItem?.call(e) ??
              Text(
                toShow(e),
                style: const TextStyle(color: blackColor, fontWeight: FontWeight.w400, fontFamily: fontFamilyName, fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
        );
      }).toList(),
      isDense: true,
      hint: hintText != null ? Text(hintText!) : null,
      // keyboardType: keyboardType,
      // maxLength: maxLength,
      // textInputAction: textInputAction,
      // cursorColor: borderColor,
      // inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
      decoration: InputDecoration(
        // hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: icon,
        constraints: const BoxConstraints(),
      ).applyDefaults(inputDecorationThemeMain),
      onChanged: isRead ? null : onChanged,
    );
  }

  Widget buildFormTitle(String title, bool required) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: titleTextColor, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        if (required)
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("*", style: TextStyle(color: Colors.red, fontSize: 12)),
          ),
      ],
    );
  }
}

class CommonButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final double? height;
  final Color color;
  final Color textColor;
  final ShapeBorder? shape;
  final TextStyle? style;
  final BorderRadiusGeometry? borderRadius;
  const CommonButton({super.key, required this.text, required this.onTap, this.color = primaryColor, this.borderRadius, this.shape, this.textColor = whiteColor, this.height, this.style});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: textColor, disabledBackgroundColor: whiteColor, disabledForegroundColor: blackColor, minimumSize: height == null ? null : Size(double.infinity, height!)),
        child: Text(text, style: style),
      ),
    );
  }
}

class QrScannerButton extends StatelessWidget {
  final void Function(String qrValue) onQrScan;
  final String? text;
  const QrScannerButton({super.key, required this.onQrScan, this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: highlightColor,
      child: InkWell(
        onTap: () async {
          final value = await context.push(const QRScannerScreen());
          onQrScan(value);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Text(text ?? "Bike QR Code", style: const TextStyle(color: blackColor)),
              const Spacer(),
              const Icon(Icons.qr_code_scanner),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonSelectionButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final bool selected;
  const CommonSelectionButton({super.key, required this.text, required this.onTap, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? primaryColor : highlightColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        splashColor: secondaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: selected ? whiteColor : blackColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class CommonFieldTypeAhead<T> extends StatelessWidget {
  final FutureOr<List<T>?> Function(String) suggestionsCallback;
  final String Function(T) toShow;
  final void Function(T)? onSelected;
  final void Function()? onRemove;

  final String? text;
  final String? hintText;
  final bool showRequired;
  final T? selected;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  const CommonFieldTypeAhead({super.key, required this.suggestionsCallback, required this.toShow, this.onSelected, this.text, this.hintText, this.showRequired = false, this.selected, this.focusNode, required this.onRemove, this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    return text != null ? Column(children: [buildFormTitle(text!, showRequired), buildTypeAheadField(context)]) : buildTypeAheadField(context);
  }

  TypeAheadField<dynamic> buildTypeAheadField(BuildContext context) {
    return TypeAheadField<T>(
      controller: selected != null ? TextEditingController(text: toShow(selected as T)) : TextEditingController(),
      suggestionsCallback: suggestionsCallback,
      loadingBuilder: (context) {
        return const Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12), child: Text("Loading..."));
      },
      emptyBuilder: (context) {
        return const SizedBox();
      },
      focusNode: focusNode,
      decorationBuilder: (context, child) {
        return Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(12),
          color: whiteColor,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: context.screenHeight * 0.4),
            child: child,
          ),
        );
      },
      itemBuilder: (context, suggestion) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Text(toShow(suggestion), style: const TextStyle(color: blackColor)),
        );
      },
      onSelected: onSelected == null
          ? null
          : (value) {
              print("object");
              onSelected!(value);
              if (nextFocusNode != null) nextFocusNode?.requestFocus();
              context.closeKeyboard();
            },
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(color: blackColor, fontWeight: FontWeight.w400, fontSize: 15),
          onSubmitted: (value) async {
            var data = await suggestionsCallback(value);
            if (nextFocusNode != null) nextFocusNode?.requestFocus();

            if (data != null && data.isNotEmpty) {
              onSelected!(data.first);
            }
          },
          decoration: InputDecoration(
            suffixIcon: selected != null && onRemove != null
                ? GestureDetector(
                    onTap: () {
                      onRemove?.call();
                    },
                    child: const Icon(Icons.close),
                  )
                : const Icon(Icons.search),
            hintText: hintText ?? "Search here...",
            //hintStyle: TextStyle(color: blackColorLight),
          ).applyDefaults(inputDecorationThemeMain),
        );
      },
    );
  }

  Widget buildFormTitle(String title, bool required) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(color: whiteColor, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        if (required)
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("*", style: TextStyle(color: Colors.red, fontSize: 12)),
          ),
      ],
    );
  }
}

class UnderlineTextButton extends StatefulWidget {
  final String text;
  final void Function()? onTap;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final Color textColor;
  final Color focusColor;
  final Color bgColor;
  final FontWeight fontWeight;
  final bool showUnderlineOnHover;
  final double verticalPadding;
  final double horizontalPadding;
  final bool isDisabled;
  final bool onlyHoverUndeline;
  final bool showUndelineAnyWay;
  final bool onlyGestureDetector;

  const UnderlineTextButton({super.key, this.textStyle = const TextStyle(fontSize: 14, height: 1), this.textAlign = TextAlign.left, this.textColor = whiteColor, this.focusColor = whiteColor, this.fontWeight = FontWeight.w500, this.showUnderlineOnHover = true, this.onlyHoverUndeline = false, this.isDisabled = false, this.showUndelineAnyWay = false, this.onlyGestureDetector = false, this.verticalPadding = 5, this.horizontalPadding = 5, required this.onTap, required this.text, required this.bgColor});

  @override
  State<UnderlineTextButton> createState() => _UnderlineTextButtonState();
}

class _UnderlineTextButtonState extends State<UnderlineTextButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: isHover ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (event) {
        setState(() => isHover = true);
      },
      onExit: (event) {
        setState(() => isHover = false);
      },
      onHover: (event) {
        setState(() => isHover = true);
      },
      child: kIsWeb && !widget.onlyGestureDetector
          ? InkWell(
              onTap: widget.isDisabled ? null : widget.onTap,
              radius: 0.00001,
              child: ColoredBox(color: widget.bgColor, child: textWidget()),
            )
          : GestureDetector(
              onLongPressStart: (details) {
                setState(() => isHover = true);
              },
              onLongPressEnd: (details) {
                setState(() => isHover = false);
              },
              onLongPressCancel: () {
                setState(() => isHover = false);
              },
              onTap: widget.isDisabled ? null : widget.onTap,
              child: textWidget(),
            ),
    );
  }

  Padding textWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.verticalPadding, horizontal: widget.horizontalPadding),
      child: Text(
        widget.text,
        style: widget.textStyle.apply(color: widget.textColor, decoration: ((widget.showUnderlineOnHover && isHover && !widget.isDisabled) || widget.showUndelineAnyWay) ? TextDecoration.underline : TextDecoration.none, decorationColor: widget.focusColor).copyWith(decorationThickness: 2, fontWeight: widget.fontWeight),
        textAlign: widget.textAlign,
      ),
    );
  }
}
