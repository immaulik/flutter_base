import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef PaginationItemBuilder<T> = Widget Function(T t);

class PaginationListView<T> extends StatefulWidget {
  final int itemCount;
  final PaginationItemBuilder<T> itemView;
  final Function? separatorView;
  final List<T> dataList;
  final bool finishPagination;
  final Function? loadingView;
  final EdgeInsetsGeometry? padding;
  final Function? onPaginate;
  final bool separated;
  final int pageLimit;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final bool primary;

  const PaginationListView({
    super.key,
    required this.itemCount,
    required this.itemView,
    required this.dataList,
    this.loadingView,
    this.finishPagination = false,
    this.padding,
    this.onPaginate,
    this.scrollController,
    this.physics,
    this.primary = false,
    required this.pageLimit,
  })  : separated = false,
        separatorView = null;

  const PaginationListView.separated({
    super.key,
    required this.itemCount,
    required this.itemView,
    required this.separatorView,
    required this.dataList,
    this.loadingView,
    this.finishPagination = false,
    this.padding,
    this.onPaginate,
    this.scrollController,
    this.physics,
    this.primary = false,
    required this.pageLimit,
  }) : separated = true;

  @override
  State<PaginationListView<T>> createState() => _PaginationListviewState<T>();
}

class _PaginationListviewState<T> extends State<PaginationListView<T>> {
  late ScrollController scrollController;
  bool paginating = false;
  bool finished = false;

  @override
  void initState() {
    scrollController = widget.scrollController ?? ScrollController();
    finished = widget.itemCount == 0 || widget.itemCount < widget.pageLimit;
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PaginationListView<T> oldWidget) {
    if (widget.itemCount > oldWidget.itemCount) {
      setState(() {
        paginating = false;
        finished = widget.itemCount == 0 || widget.itemCount < widget.pageLimit;
      });
    } else {
      setState(() {
        finished = true;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.separated) {
      return ListView.separated(
        primary: widget.primary,
        shrinkWrap: true,
        physics: widget.physics,
        padding: widget.padding,
        itemBuilder: (BuildContext context, int index) {
          if (widget.itemCount != index) {
            return widget.itemView(widget.dataList[index]);
          } else if (!widget.finishPagination) {
            if (widget.loadingView != null) {
              return widget.loadingView!();
            } else {
              return const _DefaultLoadingView();
            }
          } else {
            return const SizedBox();
          }
        },
        itemCount: finished ? widget.itemCount : (widget.itemCount + 1),
        separatorBuilder: (BuildContext context, int index) {
          return widget.separatorView!();
        },
      );
    } else {
      return ListView.builder(
        controller: scrollController,
        physics: widget.physics,
        padding: widget.padding,
        itemBuilder: (BuildContext context, int index) {
          if (widget.itemCount != index) {
            return widget.itemView(widget.dataList[index]);
          } else if (!widget.finishPagination) {
            if (widget.loadingView != null) {
              return widget.loadingView!();
            } else {
              return const _DefaultLoadingView();
            }
          } else {
            return const SizedBox();
          }
        },
        itemCount: finished ? widget.itemCount : widget.itemCount + 1,
      );
    }
  }

  void scrollListener() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 50 &&
        !widget.finishPagination &&
        !paginating) {
      if (widget.onPaginate != null) {
        widget.onPaginate!();
        paginating = true;
      }
    }
  }
}

class _DefaultLoadingView extends StatelessWidget {
  const _DefaultLoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Loading more...",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          10.horizontalSpace,
          CircularProgressIndicator.adaptive()
        ],
      ),
    ));
  }
}
