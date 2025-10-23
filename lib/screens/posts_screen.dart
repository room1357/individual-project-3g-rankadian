import 'package:flutter/material.dart';
import '../client/rest_client.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late final RestClient _client;
  late final PostService _service;
  List<Post> _posts = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _client = RestClient();
    _service = PostService(_client);
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() => _loading = true);
    try {
      final posts = await _service.list(limit: 20);
      if (!mounted) return;
      setState(() => _posts = posts);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal memuat postingan: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _showCreateDialog() async {
    final userIdCtl = TextEditingController();
    final titleCtl = TextEditingController();
    final bodyCtl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text('Tambah Postingan'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: userIdCtl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'User ID'),
                    validator:
                        (v) =>
                            int.tryParse(v ?? '') == null
                                ? 'Masukkan user id valid'
                                : null,
                  ),
                  TextFormField(
                    controller: titleCtl,
                    decoration: const InputDecoration(labelText: 'Judul'),
                    validator:
                        (v) =>
                            (v ?? '').trim().isEmpty
                                ? 'Judul wajib diisi'
                                : null,
                  ),
                  TextFormField(
                    controller: bodyCtl,
                    decoration: const InputDecoration(
                      labelText: 'Isi Postingan',
                    ),
                    validator:
                        (v) =>
                            (v ?? '').trim().isEmpty ? 'Isi wajib diisi' : null,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    Navigator.of(context).pop(true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF667eea),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Tambah'),
              ),
            ],
          ),
    );

    if (result == true) {
      final post = Post(
        userId: int.tryParse(userIdCtl.text) ?? 1,
        title: titleCtl.text,
        body: bodyCtl.text,
      );
      setState(() => _posts.insert(0, post));
      try {
        final created = await _service.create(post);
        if (!mounted) return;
        setState(() => _posts[0] = created);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post berhasil ditambahkan')),
        );
      } catch (e) {
        if (!mounted) return;
        setState(() => _posts.removeAt(0));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal menambah post: $e')));
      }
    }
  }

  Future<void> _deletePost(int index) async {
    final id = _posts[index].id;
    if (id == null) {
      setState(() => _posts.removeAt(index));
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text('Hapus Postingan'),
            content: const Text(
              'Apakah Anda yakin ingin menghapus postingan ini?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF667eea),
                ),
                child: const Text('Hapus'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      setState(() => _posts.removeAt(index));
      try {
        await _service.delete(id);
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Post berhasil dihapus')));
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal menghapus: $e')));
      }
    }
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol Back
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Text(
                      'Daftar Postingan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.refresh_rounded),
                        color: Colors.white,
                        onPressed: _loadPosts,
                      ),
                    ),
                  ],
                ),
              ),

              // Body
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child:
                      _loading
                          ? const Center(child: CircularProgressIndicator())
                          : _posts.isEmpty
                          ? const Center(
                            child: Text(
                              'Belum ada postingan',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.all(20),
                            itemCount: _posts.length,
                            itemBuilder: (context, index) {
                              final post = _posts[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  title: Text(
                                    post.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      post.body,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete_rounded,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () => _deletePost(index),
                                  ),
                                ),
                              );
                            },
                          ),
                ),
              ),
            ],
          ),
        ),
      ),

      // FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF667eea),
        onPressed: _showCreateDialog,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
    );
  }
}
