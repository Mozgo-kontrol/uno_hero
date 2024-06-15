// 1. Rename the class to be more descriptive.
class TournamentCreationPage extends StatelessWidget {
  const TournamentCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final themeData = Theme.of(context);
    final titleController = TextEditingController();
    final playerNameController = TextEditingController();

    // 2. Extract the BlocProvider to a separate variable for better readability.
    final createTournamentBloc = BlocProvider.of<CreateTournamentBloc>(context);

    void sendNewEvent(CreateTournamentEvent newEvent) {
      createTournamentBloc.add(newEvent);
    }

    return BlocBuilder<CreateTournamentBloc, CreateTournamentState>(
        bloc: createTournamentBloc..add(CreateTournamentInitEvent()),
        builder: (context, state) {
          if (state is CreateTournamentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is CreateTournamentData) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: Text("New Tournament",
                    style: themeData.textTheme.headlineLarge),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded,
                      color: themeData.appBarTheme.foregroundColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 3. Use a more descriptive widget name for the title section.
                    _buildTitleInput(themeData, titleController, size),
                    // 4. Use a more descriptive widget name for the player addition section.
                    _buildAddPlayerInput(
                        themeData, playerNameController, size, sendNewEvent),
                    // 5. Use a more descriptive widget name for the player list section.
                    _buildPlayerList(state, sendNewEvent),
                    // 6. Use a more descriptive widget name for the action buttons section.
                    _buildActionButtons(context, state),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  // 7. Extract the title input section into a separate widget for better organization.
  Widget _buildTitleInput(ThemeData themeData,
      TextEditingController titleController, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text("Title", style: themeData.textTheme.headlineMedium),
        ),
        SizedBox(
          width: size.width,
          child: TextField(
            style: themeData.textTheme.bodyMedium,
            controller: titleController,
            keyboardType: TextInputType.text,
            autofocus: false,
            maxLength: 25,
            decoration: const InputDecoration(
              hintText: 'Enter Title for your Tournament',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 8. Extract the player addition input section into a separate widget.
  Widget _buildAddPlayerInput(ThemeData themeData,
      TextEditingController playerNameController, Size size,
      Function(CreateTournamentEvent) sendNewEvent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text("Add player", style: themeData.textTheme.headlineMedium),
        ),
        SizedBox(
          width: size.width,
          child: TextField(
            style: themeData.textTheme.bodyMedium,
            controller: playerNameController,
            autofocus: false,
            keyboardType: TextInputType.text,
            maxLength: 25,
            decoration: InputDecoration(
              hintText: 'Enter player name',
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  sendNewEvent(AddPlayerEvent(playerNameController.text));
                },
                child: const Icon(Icons.add_circle, color: Colors.green, size: 35),
              ),
            ),
          ),
        ),
      ],
    );